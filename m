Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <96dff5a60706081953w348e5a2dl3d76411b5fa7124f@mail.gmail.com>
Date: Fri, 8 Jun 2007 22:53:55 -0400
From: "Mo.Shahin" <mohamed.shaheen@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200706082336.00557.dgollub@suse.de>
MIME-Version: 1.0
References: <200706082336.00557.dgollub@suse.de>
Subject: Re: [Bluez-devel] [PATCH] Input Service - Support for hidd
	configuration
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0838361776=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0838361776==
Content-Type: multipart/alternative;
	boundary="----=_Part_87288_28593885.1181357635109"

------=_Part_87288_28593885.1181357635109
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Daniel,
This is Mo from Canada, I was looking for a developer to develop a bluetooth
application over this board (http://acmesystems.it/?id=4)
The target from this project is to build a bluetooth marketing solution
along with interactivity with cell phone users and I was wondering if you
are interested in such project or not, and if you have any contact who might
be interested
Regards,
Mo.

On 6/8/07, Daniel Gollub <dgollub@suse.de> wrote:
>
> Hi,
>
> attachted an input service patch which implements support for the hidd
> configuration. This is needed to have a smooth transition from hidd daemon
> to
> the new shiny input service ...
>
> ( ... and especially this is needed to be able to return from vacation
> back to
> the office - without getting blamed by Seife for not working bluetooth
> input
> devices ;P )
>
> The patch reads the entries of hidd and stores it with store_device_info()
> function. The hidd doesn't get modified - this means the transition
> happens
> on every start of the input service. store_device_info() avoids duplicate
> entries. So there is still the possibility to have a working bluetooth
> input
> device when falling back to hidd.
>
> best regards,
> Daniel
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
>
>

------=_Part_87288_28593885.1181357635109
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Daniel,<br>This is Mo from Canada, I was looking for a developer to develop a bluetooth application over this board (<a href="http://acmesystems.it/?id=4">http://acmesystems.it/?id=4</a>) <br>The target from this project is to build a bluetooth marketing solution along with interactivity with cell phone users and I was wondering if you are interested in such project or not, and if you have any contact who might be interested
<br>Regards,<br>Mo.<br><br><div><span class="gmail_quote">On 6/8/07, <b class="gmail_sendername">Daniel Gollub</b> &lt;<a href="mailto:dgollub@suse.de">dgollub@suse.de</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br><br>attachted an input service patch which implements support for the hidd<br>configuration. This is needed to have a smooth transition from hidd daemon to<br>the new shiny input service ...<br><br>( ... and especially this is needed to be able to return from vacation back to
<br>the office - without getting blamed by Seife for not working bluetooth input<br>devices ;P )<br><br>The patch reads the entries of hidd and stores it with store_device_info()<br>function. The hidd doesn&#39;t get modified - this means the transition happens
<br>on every start of the input service. store_device_info() avoids duplicate<br>entries. So there is still the possibility to have a working bluetooth input<br>device when falling back to hidd.<br><br>best regards,<br>Daniel
<br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.
<br><a href="http://sourceforge.net/powerbar/db2/">http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br><br><br></blockquote></div><br>

------=_Part_87288_28593885.1181357635109--


--===============0838361776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0838361776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0838361776==--
