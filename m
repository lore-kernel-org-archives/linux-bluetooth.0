Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4712F226.5040506@celunite.com>
Date: Mon, 15 Oct 2007 10:22:54 +0530
From: rahul <rahul.tank@celunite.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <d5d240eb0710120713r27a2ddcfm84493a711187bcb3@mail.gmail.com>
In-Reply-To: <d5d240eb0710120713r27a2ddcfm84493a711187bcb3@mail.gmail.com>
Subject: Re: [Bluez-users] problem in browsing services through dbus
	interface.
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

rohit puri wrote:
> hi all,
>
> I am browsing the services using the dbus interface.but my code gives 
> the following error
> `get_remote_service_channel':
> /root/marcel/main.c:78: undefined reference to `sdp_extract_pdu'
> /root/marcel/main.c:81: undefined reference to `sdp_get_access_protos'
> /root/marcel/main.c:85: undefined reference to `sdp_get_proto_port'
> /root/marcel/main.c:88: undefined reference to `sdp_list_free'
> /root/marcel/main.c:89: undefined reference to `sdp_list_free'
> /root/marcel/main.c:92: undefined reference to `sdp_record_free'
> collect2: ld returned 1 exit status
> Does someone know how to rectify this problem.
>
> Thanks in advance
>
Have you compiled the sources on your own? . If yes, then i think you 
have linked the bluez-utils to the correct bluez-libs.



thanks,
  rahul


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
