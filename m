Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB51438FAE
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Nov 2023 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from p3plsmtpa12-02.prod.phx3.secureserver.net (p3plsmtpa12-02.prod.phx3.secureserver.net [68.178.252.231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D993C01
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Nov 2023 14:36:39 -0800 (PST)
Received: from [192.168.0.7] ([136.62.128.159])
	by :SMTPAUTH: with ESMTPSA
	id 1DdZrQOLEWM4q1DdarzLCZ; Thu, 09 Nov 2023 15:36:34 -0700
X-CMAE-Analysis: v=2.4 cv=Ju037u0C c=1 sm=1 tr=0 ts=654d5ef2
 a=lUnnwqvLVv+Y9Ht0Pl0b8w==:117 a=lUnnwqvLVv+Y9Ht0Pl0b8w==:17
 a=IkcTkHD0fZMA:10 a=W5Xv9X5WnzfDc2oIEt0A:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: ethan@braneaudio.com
Message-ID: <94061775-df7e-4aa5-b760-94a28a13667f@braneaudio.com>
Date: Thu, 9 Nov 2023 16:36:32 -0600
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: a2dp delay reporting
Content-Language: en-US
From: Ethan White <ethan@braneaudio.com>
To: linux-bluetooth@vger.kernel.org
References: <b7c90f4c-8868-42ea-86c0-3f9f2b0f27e0@braneaudio.com>
In-Reply-To: <b7c90f4c-8868-42ea-86c0-3f9f2b0f27e0@braneaudio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBdPm3UaF0U1DmRV0JBkeRsWDk60G5x92h1VDAEKJV2RT9S3B4RA8oxaVKD/9rioFV7tnTZPbpAVH49ZeqtFVfqFS1V6H9NtfYRYrSG/uiipcv4HEA9w
 gZJqE2iNpqaBbhEvkRTxcY5ExdaEbAV3MKySYS5A7h6Ht2UV9fl1lmvmyiYp1mecsN0WMfb54ngTbR36xAjwfzj0pDhi0oO+7LY=

On 10/17/23 13:10, Ethan White wrote:
> Hi,
> 
> How do I inform Bluez of my a2dp transport delay?  The media-api 
> document shows a Delay property for the MediaTransport1 interface but 
> attempts at writing this property yield the following error:
> 
> org.freedesktop.DBus.Error.PropertyReadOnly: Property 'Delay' is not 
> writable
> 
> 
> Reviewing profiles/audio/transport.c a2dp_properties (Bluez 5.70) I find 
> that the delay property does not have a set function:
> 
> line 846: { "Delay", "q", get_delay_reporting, NULL, 
> delay_reporting_exists },
> 
> 
> What am I missing here?  How an I supposed to inform the a2dp source of 
> my playback delay?  Thanks for any help.
> 
> Regards,
> Ethan

I'm currently using org.bluez.Media1 RegisterEndpoint to expose my a2dp 
sink to a2dp sources.  I use org.bluez.MediaTransport1 Acquire to get 
the transport.  I can write the 'Volume' property of 
org.bluez.MediaTransport1 to change the audio source volume.  However, 
writing to the 'Delay' property of the org.bluez.MediaTransport1 
interface yields only errors as this property appears to be read-only 
despite bluez/docs/media-api.rst showing this property to be read/write.

When using busctl from the host running my a2dp sink to inspect the 
transport I get a dash '-' in place of a numerical value:
host:~$ busctl introspect  org.bluez 
/org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx/fd0
NAME                                TYPE      SIGNATURE RESULT/VALUE 
                        FLAGS
org.bluez.MediaTransport1           interface -         - 
                        -
.Acquire                            method    -         hqq 
                        -
.Release                            method    -         - 
                        -
.TryAcquire                         method    -         hqq 
                        -
.Codec                              property  y         2 
                        emits-change
.Configuration                      property  ay        6 128 1 4 131 
232 0                     emits-change
.Delay                              property  q         - 
                        emits-change
.Device                             property  o 
"/org/bluez/hci0/dev_E8_78_65_F2_14_24" emits-change
.State                              property  s         "active" 
                        emits-change
.UUID                               property  s 
"0000110b-0000-1000-8000-00805f9b34fb"  emits-change
.Volume                             property  q         64 
                        emits-change writable
org.freedesktop.DBus.Introspectable interface -         - 
                        -
.Introspect                         method    -         s 
                        -
org.freedesktop.DBus.Properties     interface -         - 
                        -
.Get                                method    ss        v 
                        -
.GetAll                             method    s         a{sv} 
                        -
.Set                                method    ssv       - 
                        -
.PropertiesChanged                  signal    sa{sv}as  - 
                        -

Does Bluez allow an a2dp sink to report its playback delay to the a2dp 
source via the org.bluez.MediaTransport1 Delay property?  Is there some 
other way to communicate this delay back to the audio source for proper 
lip-sync with video?

Regards,
Ethan

