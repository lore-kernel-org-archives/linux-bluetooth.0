Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41FF54DA.40801@ul.ie>
From: Joe Sloan <joe.sloan@ul.ie>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Trying to compile for axis but Bluetooth library
 not found
References: <41FE85A0.2040709@ieee.org> <1107204712.15769.70.camel@justakiss>
In-Reply-To: <1107204712.15769.70.camel@justakiss>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 01 Feb 2005 10:07:22 +0000


>Hi,
>it seems that your options for configure are wrong for cross
>compilation. --host specifies the system where the package will run.
>This should be cris-axis-linux in your case, I guess.
>
>As a general hint for cross compiling:
>* Set CC,CFLAGS and LDFLAGS that you need for cross compiling in the
>environment.
>* use "./configure --host=<your target architecture>" (and special
>options that are required, but don't use --target or --build !!)
>
>For bluez-utils-2.10, I had to specify --with-bluez=.. and --with-usb=..
>with the path were the bluez-libs includes were installed.
>
>Hope that helps
>Erwin
>  
>
Thanks Erwin. I also used --libdir=  too and I can compile the utils. 
(Haven't tested them yet - trying to get the kernel up and running).

I wasn't sure about using --host as the script gave some kind of error 
about not using it.




 


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
