Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46DB968E.40203@gmail.com>
Date: Mon, 03 Sep 2007 10:37:26 +0530
From: Rahul Tank <gr8rahul@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <9346e8090709020731k60893fe5xaf27e01a8c292761@mail.gmail.com>
	<9346e8090709020805j53dbcc8blba0f42eeecb2c6c6@mail.gmail.com>
In-Reply-To: <9346e8090709020805j53dbcc8blba0f42eeecb2c6c6@mail.gmail.com>
Subject: Re: [Bluez-devel] bluez-utils-3.17 installation problem
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Richeek Arya wrote:
>
> service.c: In function 'update_svclass_list':
> service.c:83: error: 'sdp_record_t' has no member named 'svclass'
> service.c:86: error: 'sdp_record_t' has no member named 'svclass'
> service.c: In function 'create_ext_inquiry_response':
> service.c:170: error: 'sdp_record_t' has no member named 'svclass'
> service.c:173: error: 'sdp_record_t' has no member named 'svclass'
> service.c:182: error: 'sdp_record_t' has no member named 'svclass'
> service.c:188: error: 'sdp_record_t' has no member named 'svclass'
> make[2]: *** [ service.o] Error 1
> make[2]: Leaving directory `/home/richeek/Desktop/bluez-utils-3.17/sdpd'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/richeek/Desktop/bluez-utils-3.17'
> make: *** [all] Error 2
>
IMHO  it is not finding the bluez library. Either bluez-libs is not 
installed or it is not getting the library path.

> My gcc version is 4.1.1. How to solve this problem??
> With due regards..
> -- 
> richeek arya
> GHEB-143
> iiit hyderabad
>
> -- 
> richeek arya
> GHEB-148
> iiit hyderabad
> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   


thanks,
  rahul .

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
