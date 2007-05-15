Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d4060d560705150327g611491f1mbdad82b3f75699f7@mail.gmail.com>
Date: Tue, 15 May 2007 15:57:49 +0530
From: "Rupesh Gujare" <rupeshgujare@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1179223118.10069.2.camel@violet>
MIME-Version: 1.0
References: <d4060d560705150247g46030f61sa080f4485ab28d85@mail.gmail.com>
	<1179223118.10069.2.camel@violet>
Subject: Re: [Bluez-devel] Can i get address of device who is doing
	discovery?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0458816040=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0458816040==
Content-Type: multipart/alternative;
	boundary="----=_Part_49947_31711780.1179224869967"

------=_Part_49947_31711780.1179224869967
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Is there any other way of doing this task?
                 Actually I want to generate some event from mobile device
which will give me its address. So that i can start communication with it.
(without having any software on mobile side).

Regards
 Rupesh

On 5/15/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Rupesh,
>
> >   I want to get address of a device who is doing discovery. (while my
> > local device is responding to discovey) I know that while doing
> > discovery a device sends a FHS packet which contains its address and
> > clock information.
> >   But i dont know how to hack code to extract its BD Adress.
>
> it is impossible to do that with the HCI interface.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_49947_31711780.1179224869967
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Is there any other way of doing this task? <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Actually I want to generate some event from mobile device which will give me its address. So that i can start communication with it. (without having any software on mobile side).
<br><br>Regards<br>&nbsp;Rupesh<br><br><div><span class="gmail_quote">On 5/15/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Rupesh,<br><br>&gt;&nbsp;&nbsp; I want to get address of a device who is doing discovery. (while my<br>&gt; local device is responding to discovey) I know that while doing<br>&gt; discovery a device sends a FHS packet which contains its address and
<br>&gt; clock information.<br>&gt;&nbsp;&nbsp; But i dont know how to hack code to extract its BD Adress.<br><br>it is impossible to do that with the HCI interface.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------
<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br><a href="http://sourceforge.net/powerbar/db2/">
http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br>

------=_Part_49947_31711780.1179224869967--


--===============0458816040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0458816040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0458816040==--
