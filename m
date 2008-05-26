Return-Path: <cyrus@holtmann.org>
Message-ID: <8c8e9de90805251933u7d8df0d3jee16ad550aa6a187@mail.gmail.com>
Date: Mon, 26 May 2008 10:33:02 +0800
From: "Yuchih Liu" <liuyuchih@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-users] [Bluez-devel] immediate unsolicited disconnect
	after hcitool cc
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0234554209=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0234554209==
Content-Type: multipart/alternative;
	boundary="----=_Part_6149_3717241.1211769182053"

------=_Part_6149_3717241.1211769182053
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

On 2/18/07, Marcel Holtmann <marcel@ho...> wrote:
> Hi Choi,
>
> > after I do "hcitool cc xx:xx:xx:xx:xx:xx" I have a connection
> > I can see with "hcitool con" but after one or two seconds I can
> > see in hcidump that an HCI disconnect command is sent and
> > the connection is disconnected.
>
> don't use this command for piconet creation. Use higher layer like L2CAP
> and RFCOMM. The kernel will create the needed ACL link for you and take
> fully care of it.

I am doing some experience on the HCI level.
Is there any HCI command i could use to maintain connection for a while?
I have tried "Write Link Supervision Timeout Command", but not work.
Shall i do something like unpark and then park the slavers?

Thanks very much for your help,

Yuchih

------=_Part_6149_3717241.1211769182053
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,<br>
 <br>On 2/18/07, Marcel Holtmann &lt;marcel@ho...&gt; wrote:<br>
 &gt; Hi Choi,<br>
 &gt;<br>
 &gt; &gt; after I do &quot;hcitool cc xx:xx:xx:xx:xx:xx&quot; I have a connection<br>
 &gt; &gt; I can see with &quot;hcitool con&quot; but after one or two seconds I can<br>
 &gt; &gt; see in hcidump that an HCI disconnect command is sent and<br>
 &gt; &gt; the connection is disconnected.<br>
 &gt;<br>
 &gt; don&#39;t use this command for piconet creation. Use higher layer like L2CAP<br>
 &gt; and RFCOMM. The kernel will create the needed ACL link for you and take<br>
 &gt; fully care of it.<br><br>I am doing some experience on the HCI level.<br>Is there any HCI command i could use to maintain connection for a while?<br>I have tried &quot;Write Link Supervision Timeout Command&quot;, but not work.<br>
Shall i do something like unpark and then park the slavers?<br><br>Thanks very much for your help,<br><br>Yuchih<br>

------=_Part_6149_3717241.1211769182053--


--===============0234554209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0234554209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0234554209==--
