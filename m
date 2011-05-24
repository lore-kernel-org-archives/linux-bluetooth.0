Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110524083723.GB2480@null>
References: <1306199164-28310-1-git-send-email-jaikumar@google.com>
	<20110524083723.GB2480@null>
Date: Tue, 24 May 2011 19:20:37 +0300
Message-ID: <BANLkTi=LasZ4Ajg2apoDCGoyHZ425k28xQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add BT_POWER L2CAP socket option.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: ext Jaikumar Ganesh <jaikumar@google.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaikumar,

On Tue, May 24, 2011 at 11:37 AM, Ville Tervo <ville.tervo@nokia.com> wrote:
> Hi Jaikumar,
>
> On Mon, May 23, 2011 at 06:06:04PM -0700, ext Jaikumar Ganesh wrote:
>> Add BT_POWER socket option used to control the power
>> characteristics of the underlying ACL link. When the remote end
>> has put the link in sniff mode and the host stack wants to send
>> data we need need to explicitly exit sniff mode to work well with
>> certain devices (For example, A2DP on Plantronics Voyager 855).
>> However, this causes problems with HID devices.
>>
>> Hence, moving into active mode when sending data, irrespective
>> of who set the sniff mode has been made as a socket option. By
>> default, we will move into active mode. HID devices can set the
>> L2CAP socket option to prevent this from happening.
>>
>
> I would prefer keeping old way the default way. Otherwise you need to update
> all socket users in user space. Other that that this looks good to me.

What is wrong that we need such control to be done in userspace?


-- 
Luiz Augusto von Dentz
Computer Engineer
