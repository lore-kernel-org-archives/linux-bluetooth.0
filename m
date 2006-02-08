Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sdp_record_register()
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1139398021.8573.17.camel@localhost.localdomain>
References: <1139312694.8422.19.camel@localhost.localdomain>
	 <1139356568.22790.73.camel@localhost>
	 <1139398021.8573.17.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1139402899.29208.10.camel@localhost>
Mime-Version: 1.0
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
Date: Wed, 08 Feb 2006 13:48:19 +0100

Hi Ari,

> > > Function call:
> > > err = sdp_record_register(session, record, 0);
> > > returns zero and error is 'Illegal seek'.
> > > Arguments should be ok (session is return value of successful call to
> > > sdp_connect() and record works ok with another function calls).
> > > What might be wrong?
> > 
> > the sdp_connect() has been done to the local SDP server, right. You
> > can't register SDP records for remote connections.
> > 
> 
> In sdp_record_register() there is:
> 
>         if (!session->local) {
>           errno = EREMOTE;
>           return -1;
>         }
> 
> Did you mean this by the remote connection (the program passes this test)? 
> Anyway, it seems to be that the only way to sdp_record_register() return ESPIPE (Illegal seek) error is when call to sdp_send_req_w4_rsp() fails. Does this give any hint?

make sure that sdpd process is running. Follow the examples from sdptool
or pand.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
