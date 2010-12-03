Return-Path: <cyrus@holtmann.org>
From: "Brian Gix" <bgix@codeaurora.org>
To: "'Claudio Takahasi'" <claudio.takahasi@openbossa.org>,
	"'Mike Tsai'" <Mike.Tsai@atheros.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1291305728-3463-1-git-send-email-ext-jablonski.radoslaw@nokia.com>	<20101202162236.GA1291@jh-x301>	<000001cb927b$08458e80$18d0ab80$@org>	<35B17FE5076C7040809188FBE7913F98406D794075@SC1EXMB-MBCL.global.atheros.com> <AANLkTi=gWTQXcfisupHXs9qVpHbUbYZ1yxxqKf2Mm9EU@mail.gmail.com>
In-Reply-To: <AANLkTi=gWTQXcfisupHXs9qVpHbUbYZ1yxxqKf2Mm9EU@mail.gmail.com>
Subject: RE: Are LE connections possible yet?
Date: Fri, 3 Dec 2010 11:01:13 -0800
Message-ID: <000301cb931c$74e56870$5eb03950$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio & Mike

-----Original Message-----
From: Claudio Takahasi [mailto:claudio.takahasi@openbossa.org] 
Sent: 03 December, 2010 10:07 AM
To: Mike Tsai
Cc: Brian Gix; linux-bluetooth@vger.kernel.org
Subject: Re: Are LE connections possible yet?

Hi All,

On Thu, Dec 2, 2010 at 10:21 PM, Mike Tsai <Mike.Tsai@atheros.com> wrote:
> Hi Brian,
>
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Brian Gix
> Sent: Thursday, December 02, 2010 3:46 PM
> To: linux-bluetooth@vger.kernel.org
> Subject: Are LE connections possible yet?
>
> Hi All,
>
> I am bringing up an LE capable (BR/EDR/LE) baseband, and attempting to use
> it to establish a
> GATT/ATT connection over an LE link.  However when executing the command:
>
> % ./tools/hcitool lecc 00:14:BB:55:66:77
>
> I get a very rapid failure of:
>
> "Could not create connection: Operation not permitted"
>
> The correct HCI command does not appear to be making it to the BR/EDR/LE
> baseband.
>
> It appears to be a socket issue of some sort.  I can cause this error, when
> attached to the baseband, and:
> "Could not create connection: File descriptor in bad state"
>
> if I have not yet run hciattach.
>
> Other (BR/EDR) hcitool commands work as expected, such as "hcitool scan" and
> "hcitool inq"
> [MTsai]which kernel driver you are using? It seems the kernel does not know the LE create connection OpCode?
>
>
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

For hcitool lecc it is not necessary a LE "capable" kernel, hcitool
sends the HCI commands from the userspace.
Try sudo hcitool lecc ... and don't forget putting the remote on
advertising mode: $hciconfig hcix leadv

If you want to test the connections managed by the kernel use Ville's kernel:
git://git.kernel.org/pub/scm/linux/kernel/git/vtervo/bluetooth-le-2.6.git

l2test support LE connections, use -J option to pass the fixed channel 4

[Gix] So I am cloning Ville's kernel as I type.  I did get the LE connection up and running (raw LE ACL connections, "sudo" was the key) but I will need it to be talking on Fixed channel 4, because it is a non-bluez server that I am connecting to, which does use Fixed-4.  This will probably take me the rest of the day.

[Gix] My next question is: How long until Ville's kernel is part of the tip? 

[Gix] And how do I get gatttool to build? This may be academic until I get fixed channel 4 access via the new kernel.


Regards,
Claudio

