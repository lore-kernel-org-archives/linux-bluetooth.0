Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <f8e53fb0710172339r42591c22v857a3fd00b89d6f4@mail.gmail.com>
Date: Thu, 18 Oct 2007 08:39:41 +0200
From: "Andrea Galbusera" <gizero@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1192630825.6184.17.camel@violet>
MIME-Version: 1.0
References: <f8e53fb0710170033u2b451d7ft34cad156e0828a49@mail.gmail.com>
	<1192630825.6184.17.camel@violet>
Subject: Re: [Bluez-users] concurrent calls to RFCOMM connect()
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel,

On 10/17/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> > The common thread function will start connecting to the appropriate
> > remote device by allocating a socket and calling connect(). Do I have
> > to consider any particular syncronization issue between the threads?
> > Is this approach reasonable or not?
> >
> > I found posts in the archives about connect() returning EBUSY. This
> > has to be an   error code specific to RFCOMM sockets. When is it
> > supposed to be raised? Is it something I have to take into account in
> > my scenario?
>
> depending on how which kernel you use, this might work. Older kernel
> didn't queue the ACL link requests and so you saw problems.

I'm working with >2.6.17 kernels and >2.25 bluez. Since the
application should run also on some embedded device with 2.6.17 and
bluez 2.25, it is important for me to know in advance if the
architecture I have in mind is feasible or not.

If my kernels are affected, is the EBUSY problem something related to
the connect() call only or do I have to expect more general problems
in using threads for communication over BT sockets?


Thanks
Regards,
Andrea

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
