Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bt950 driver?
From: Stephen Crane <steve.crane@rococosoft.com>
To: rjmx@rjmx.net
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <87hdz9ufa0.wl%rjmx@rjmx.net>
References: <87hdz9ufa0.wl%rjmx@rjmx.net>
Content-Type: text/plain
Message-Id: <1073415724.26094.1110.camel@baroque.rococosoft.com>
Mime-Version: 1.0
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
Date: 06 Jan 2004 19:02:04 +0000

On Tue, 2004-01-06 at 18:02, Ron Murray wrote:
>    I downloaded the driver, but it won't compile against the current
> Bluez stuff (libs 2.5, utils 2.4, pin 0.21, sdp 1.5). I get lots of
> errors that way. And it seems that the link to the "Alternate driver
> for BT2000E Bluetooth cards" from the website is dead.

You don't compile the kernel driver against user-space stuff.

>    Any suggestions? Is there any obvious reason why bt950_cs.c won't
> compile? (I'd post the results of the compile attempt, but there's
> rather a lot of it and I don't want to needlessly clog up the list).

That would be a help. Even saying what the steps you took were would help.
For instance:

* download bt950-0.1.tar.gz from holtmann.org
* get the kernel sources for 2.4.18-pxa3-embedix from, err..., sharp's website?
* download the Embedix cross-compilation tools from http://community.zaurus.com/project/showfiles.php?group_id=18
* softlink /usr/src/linux-2.4.18-pxa3-embedix to /usr/src/linux
* edit bt950/Makefile to use arm-linux-gcc, etc.
* ...

Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
