Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alexander Holler <holler@ahsoftware.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluepin (gtk2 and actual xfree86)
Message-ID: <38490000.1071664345@[192.168.207.2]>
In-Reply-To: <27710000.1071661012@[192.168.207.2]>
References: <27710000.1071661012@[192.168.207.2]>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 17 Dec 2003 13:32:25 +0100

Hi,

I have comment myself:

--On Mittwoch, Dezember 17, 2003 12:36:52 +0100 Alexander Holler 
<holler@ahsoftware.de> wrote:

> But to get it running on my system with xfree 4.3.0 I also had to comment
> out the following two lines:
>
># --------------------------------------------
># Set X display before initializing GTK
># set_display()
>
># Some versions of fontconfig will segfault if HOME isn't set.
># os.environ['HOME'] = ""
> --------------------------------------------

Wrong. ;)

They are needed because bluepin is started by root and I've tested it as 
the logged-in user.

So the rh-patch from 2.3-14 is totally enough.

Sorry for that.

Regards,

Alexander



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
