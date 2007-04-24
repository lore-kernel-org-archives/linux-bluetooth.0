Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <fc27e74b0704240808j3ca3df0cr5c415d39acf29ac4@mail.gmail.com>
Date: Tue, 24 Apr 2007 20:38:40 +0530
From: "list subscribe" <develnewbie@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <462E02FB.8000600@vasmac.com>
MIME-Version: 1.0
References: <fc27e74b0704240413v5b6e2e80h7b2feb40d27de686@mail.gmail.com>
	<462E02FB.8000600@vasmac.com>
Subject: Re: [Bluez-devel] [PATCH]Dynamic Alternate Setting patch (hci_usb.c)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0219214597=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0219214597==
Content-Type: multipart/alternative;
	boundary="----=_Part_22488_9700911.1177427320648"

------=_Part_22488_9700911.1177427320648
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jose,



Hi Alok,
>
> This is a good start. There are a few other things to consider:
>
> * Are there error conditions in hci_usb_tx_complete that need to be
> handled?


I am not sure what you mean.  Since we don't flush submitted  URBs, these
URBs are handled like normal ones. If their status indicates error the
error_tx count will be incremented. What error conditions are u pointing at?


* How do you make sure data for different channels is interleaved?


Well , since we know that there can be max 3 SCO channels , we can have 3
separate queues, and use a round robin method to send out the packets from
the queues. i am not sure about this idea though.  What do u think?

Jose
>
>

------=_Part_22488_9700911.1177427320648
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jose,<br>&nbsp;<br><br><div><span class="gmail_quote"><br></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Alok,<br><br>This is a good start. There are a few other things to consider:
<br><br>* Are there error conditions in hci_usb_tx_complete that need to be handled?</blockquote><div><br>I am not sure what you mean.&nbsp; Since we don&#39;t flush submitted&nbsp; URBs, these URBs are handled like normal ones. If their status indicates error the error_tx count will be incremented. What error conditions are u pointing at? 
<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">* How do you make sure data for different channels is interleaved?</blockquote>
<div><br>Well , since we know that there can be max 3 SCO channels , we can have 3 separate queues, and use a round robin method to send out the packets from the queues. i am not sure about this idea though.&nbsp; What do u think?
<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jose<br><br></blockquote></div><br>

------=_Part_22488_9700911.1177427320648--


--===============0219214597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0219214597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0219214597==--
