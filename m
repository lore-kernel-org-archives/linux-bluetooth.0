Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3f5a9ba20609252330p3d14854eu7b47acc600c28daf@mail.gmail.com>
References: <3f5a9ba20609252330p3d14854eu7b47acc600c28daf@mail.gmail.com>
Date: Tue, 26 Sep 2006 10:39:16 +0200
Message-Id: <1159259956.1235.3.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Can I search two services at the same time?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

> 
>    I have seen that there is a function named sdp_service_search_req,
>    So,I append two service uuid such as obexpush's uuid and another
> service's uuid into the search list, I want to get the two services'
> info only call search func once.
>   and then set the max_rec_num = 2,
>   then call 
>        sdp_service_search_req(session,search_list,2,&rsp_list);
>  but ,I have seen that the func return 0, but the rsp_list is NULL.

this works, but your remote device does not contain any of these records
and so it reports non back to you. What kind of remote device is it you
are testing with.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
