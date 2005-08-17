Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <430313A9.8000409@ubuntu.com>
From: Charles Majola <charles@ubuntu.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] programming reference with Bluez
References: <loom.20050817T120041-103@post.gmane.org>
In-Reply-To: <loom.20050817T120041-103@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Wed, 17 Aug 2005 12:38:33 +0200

Datha wrote:

>Hi,
>Can I get some high level documents, programming reference on bluez. 
>
>I want to write a 'C' code to discover the devices around the PC, know about the
>services as it is done with the Mobile phone.
>
>For example phones like Nokia6600 will serach for devices around and gives a
>list. I know how to do that in Symbian but how is it done with the Linux?
>
>  
>
Have a look at hcitool.c in bluez-utils's source code.The basic code
should be under the function 'cmd_scan()'.

>Can somebody help me?
>
>Thanks,
>Datha
>
>
>
>  
>
--
chmj


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
