Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michael Mauch <michael.mauch@gmx.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20060524212831.GA3447@elmicha.333200002251-0001.dialin.t-online.de>
References: <e85851c20605232344p52bf1210y36273bef4ff02ce6@mail.gmail.com> <e85851c20605232349q63e37b30ta98c0dd4309c562f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e85851c20605232349q63e37b30ta98c0dd4309c562f@mail.gmail.com>
Subject: [Bluez-users] Re: Found errors
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
Date: Wed, 24 May 2006 23:28:32 +0200

Gloria Saripah Patara wrote:

> Hello, Friends. I want ask you, about error messages.
> Did you find this kind of message?
> -------- Can't establish OBEX connection : Host is down -----------
> I use perror to print the message. And function that raises the
> message is BtOBEX_TransportConnect(...., ...., ....., ....)
> 
> inside this message i attached my code.

>From your code:

        ii = (inquiry_info*)malloc(max_rsp * sizeof(inquiry_info));
        free(ii);

        return (ii->bdaddr);

That's wrong. After you freed ii, you are not allowed to access it
anymore. You may only access malloced variables between the malloc() and
the free(). After free(), the system may overwrite the contents of the
allocated memory.


  Michael


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
