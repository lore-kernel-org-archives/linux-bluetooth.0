Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <80236d750705300036v3409e6a7kcb58e9f746f6cac@mail.gmail.com>
Date: Wed, 30 May 2007 09:36:03 +0200
From: "Emanuele Novelli" <ema.novelli@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1180470054.21432.141.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <80236d750705290911g619e3d9eu8c6cda81c884b44d@mail.gmail.com>
	<1180470054.21432.141.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] [Bluez Users] Page timeout during sdp on heavy
	traffic.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1525905053=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1525905053==
Content-Type: multipart/alternative;
	boundary="----=_Part_725_4593295.1180510563791"

------=_Part_725_4593295.1180510563791
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/5/29, Marcel Holtmann <marcel@holtmann.org>:
>
> Hi Emanuele,
>
> > I wrote a little application to simulate an heavy traffic.
> > Simply discovers devices using hci0 and for each device discovered
> > starts a thread to search service using hci1.
> > Rinse and repeat forever.
> > Usually I have 5-6 bluetooth devices in the area.
> > I'm not using d-bus messaging (yet) but i guess i'll try that too to
> > check
> >
> > Anyway I noticed a large number of timeouts during search services on
> > devices who previously returned correct service record.
>
> I have no idea how often I have to say that, but you can't page devices
> at the same time. The chips simply don't support that. The same reason
> why you can run an inquiry and page at the same time. It is not
> possible. Period. And this means you have to serialize the SDP service
> requests.
>
> New kernel versions try to handling pending page attempts for piconet
> creation, but that is also limited. And simultaneous name resolve
> request can also cause troubles.
>
> Regards
>
> Marcel
>
>
Maybe I was not clear sorry, the sdp search I do on hci1 is serialized. It's
a thread started each one a new device is discovered. He does 1 sdp search
and quit. Then another one is started on next device on the list of the
discovered ones.

I know I cant do inquiry and page at same time but I read elsewhere on this
forum that using 2 separate hci at once you can actually achieve that. But
maybe I was wrong if so sorry for the silly question.
Simply I do inquiry with hci0 (never stops) and each time it finds a group
devices I start an sdp search on hci1 (1 device at time serialized) but as I
wrote sometimes this request return page timeout while other time it works
well as per the hcidump I attached on previous message.
At this time the inquiry is always running (not periodic inquiry simply a
looped inquiry request)
That's only to check what's happening on heavy traffic.

Is possible that an inquiry and an sdp on 2 separate threads even if on 2
differents hci can cause problems someway during threads context switch?

------=_Part_725_4593295.1180510563791
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">2007/5/29, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Emanuele,<br><br>&gt; I wrote a little application to simulate an heavy traffic.<br>&gt; Simply discovers devices using hci0 and for each device discovered<br>&gt; starts a thread to search service using hci1.<br>&gt; Rinse and repeat forever.
<br>&gt; Usually I have 5-6 bluetooth devices in the area.<br>&gt; I&#39;m not using d-bus messaging (yet) but i guess i&#39;ll try that too to<br>&gt; check<br>&gt;<br>&gt; Anyway I noticed a large number of timeouts during search services on
<br>&gt; devices who previously returned correct service record.<br><br>I have no idea how often I have to say that, but you can&#39;t page devices<br>at the same time. The chips simply don&#39;t support that. The same reason
<br>why you can run an inquiry and page at the same time. It is not<br>possible. Period. And this means you have to serialize the SDP service<br>requests.<br><br>New kernel versions try to handling pending page attempts for piconet
<br>creation, but that is also limited. And simultaneous name resolve<br>request can also cause troubles.<br><br>Regards<br><br>Marcel<br><br></blockquote></div><br>Maybe I was not clear sorry, the sdp search I do on hci1 is serialized. It&#39;s a thread started each one a new device is discovered. He does 1 sdp search and quit. Then another one is started on next device on the list of the discovered ones.
<br><br>I know I cant do inquiry and page at same time but I read elsewhere on this forum that using 2 separate hci at once you can actually achieve that. But maybe I was wrong if so sorry for the silly question.<br>Simply I do inquiry with hci0 (never stops) and each time it finds a group devices I start an sdp search on hci1 (1 device at time serialized) but as I wrote sometimes this request return page timeout while other time it works well as per the hcidump I attached on previous message.
<br>At this time the inquiry is always running (not periodic inquiry simply a looped inquiry request)<br>That&#39;s only to check what&#39;s happening on heavy traffic.<br><br>Is possible that an inquiry and an sdp on 2 separate threads even if on 2 differents hci can cause problems someway during threads context switch?
<br><br><br><br><br><br>

------=_Part_725_4593295.1180510563791--


--===============1525905053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1525905053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1525905053==--
