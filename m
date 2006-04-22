Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <444A7810.4090607@mail.utexas.edu>
From: Philip Langdale <philipl@mail.utexas.edu>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <444A7675.7020505@mail.utexas.edu>
In-Reply-To: <444A7675.7020505@mail.utexas.edu>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Re: Experiences with mx-5000 bluetooth mouse+keyboard combo
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 22 Apr 2006 11:38:08 -0700

Philip Langdale wrote:
> Hi all,
> 
> I decided to get myself an mx-5000 set this week and I've been fiddling
> with it and while I've got it working well, I'm not quite there yet. I
> do want to report my initial findings however.
> 
> 0) Everything works fine in HID mode. All the buttons on the mouse
>    and keyboard work correctly at the input level as reported by evtest.
> 
> 
> 5) The keyboard is in a similar situation but I have not mapped out the
>    broken usages yet, and even some of the multimedia keys that do work
>    report different codes from HID mode.
> 

This is only partially true. There are some keys that don't generate
input events in either mode, and some keys that generate different codes
in HCI mode. So, there's two problems there.

--phil


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
