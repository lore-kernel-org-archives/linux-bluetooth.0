Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40227FAD.3090606@gtmp.org>
From: Alexandre Jousset <mid@gtmp.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Belkin F8T002 PC Card problem with Bluez
References: <3F4F6BF2.6080303@gtmp.org> <1062170277.27784.138.camel@pegasus> <3F4F70B1.20200@gtmp.org> <3F50803C.607@gtmp.org> <1062425807.13729.162.camel@pegasus> <lu8ylbven9.fsf@pc22.verilab.com>
In-Reply-To: <lu8ylbven9.fsf@pc22.verilab.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 05 Feb 2004 18:38:53 +0100

	Hello,

Will Partain wrote:

> (I am picking up a thread about this card from back in September.)

[text deleted...]

> The glorious Marcel suggested 'hciattach /dev/ttyS4 bcsp'
> (which simply replies: "BCSP initialization timed out").  He
> further suggested fiddling with baud rates and the like;
> neither Alexandre not I have had any luck with that (it
> still just times out).
> 
> So: Has anyone made further progress on this device and/or
> has any suggestions?  (I am serially incompetent and short
> of time, but I'll try to help if I can.)  Thanks and regards
> to all,

	I did not try again but I can tell that, according to my experience and
what Marcel told me, the problem seems to reside on an incorrect setting
in the serial communication. So it seems to be bcsp but with other
settings. If we knew what sequence of bytes the bcsp protocol sends it
would be possible to check in the log, when attaching without bcsp but
with an other setting that 'any', to see which is good. Hm this is not
very clear but people with knowledge of this can understand ;-) In fact,
if it were possible to set the parity settings and other settings in
command line it could be simpler to try which combination is the good one...

	For the moment I can not do this because the serial module in my kernel
(the one in Mandrake 9.2) does not recognize the card. When I tested it
was with a specially compiled kernel with serial.c as a module and I was
obliged to rmmod the module to insmod it after. The problem is that I am
unable to get all modules necessary to recompile the Mandrake kernel (it
tells me things like supermount not loaded and I don't find this
module)... Anyway...

	My 2p.

Alexandre Jousset.






-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
