Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm question 3
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050203130148.58115.qmail@web60901.mail.yahoo.com>
References: <20050203130148.58115.qmail@web60901.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1107436805.11944.58.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 03 Feb 2005 14:20:04 +0100

Hi Michael,

>      I've added -lbluetooth in the command, and it successes. But when
> I run the program, the program terminates and doesn't wait for any
> mobile terminal involving into the program. What is the problem about
> my program?

if you copied only the code without actually understanding what it does,
then you also copied the output of the error messages to the syslog and
an exit(1) if something fails. Check for error messages in your log
files on the system.

>  And need I really link the header files in bluez-libs/include? If so,
> should I include like this "bluez-libs-2.14/include/xx.h"? But
> the /usr/include contains the files. So I wish to know why if it is
> so.

I think you should buy yourself a C programming book first, because this
mailing list is not for teaching how to do C or socket programming or
how to use the gcc. And btw you link object code or libraries, but you
include header files.

And as a side note. Don't send code with such a stupid indentation. We
use a tab with the size of 8 spaces. You should also stop sending HTML
encoded emails. This is a mailing list and the prefered format is a
7-bit ASCII encoding.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
