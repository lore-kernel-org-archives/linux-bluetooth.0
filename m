Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1691350.CipnhsEWy0@uw000953>
References: <1386948800.23365.2.camel@pc.interlinx.bc.ca>
	<1386949351.6234.0.camel@nuvo>
	<1386949827.23365.9.camel@pc.interlinx.bc.ca>
	<1691350.CipnhsEWy0@uw000953>
Date: Fri, 13 Dec 2013 14:17:52 -0200
Message-ID: <CAJdJm_POfMm8mtbRAWdG9W3F2PwT8kNYkiHYToVZeVz+D1F+TQ@mail.gmail.com>
Subject: Re: Failed to connect: org.bluez.Error.NotReady
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "Brian J. Murrell" <brian@interlinx.bc.ca>,
	Bastien Nocera <hadess@hadess.net>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Dec 13, 2013 at 1:56 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
>> [bluetooth]# connect 7C:1E:52:6E:59:D2
>> Attempting to connect to 7C:1E:52:6E:59:D2
>> Failed to connect: org.bluez.Error.NotReady
>>
>> I have this same problem with my previously paired headset also.  Not
>> connected and won't connect.
>
> Is your adapter powered?:)

I agree it looks like it's missing "power on" command on bluetoothctl
here (assuming there is no UI applet running that should take care of
powering it up automatically.)

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
