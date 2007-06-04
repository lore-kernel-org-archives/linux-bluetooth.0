Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 4 Jun 2007 08:17:55 -0700 (PDT)
From: walt shekrota <penguinacity@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300706032041r78a9d91ata7a0ea7a90c8d482@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <995638.27392.qm@web62306.mail.re1.yahoo.com>
Subject: Re: [Bluez-users] alsa module rebuild
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1831942022=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1831942022==
Content-Type: multipart/alternative; boundary="0-1357187761-1180970275=:27392"
Content-Transfer-Encoding: 8bit

--0-1357187761-1180970275=:27392
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Ok due to the fact alsa can be configured in or out of the kernel I would assume that the piece of bt that interfaces to it should eventually be in the kernel?
 Or is the advisement that if you use bt you should seriously consider configuring your alsa modular as opposed to kernel?
 
 Will that work better for most people?
 
 Thanks.
 -Walt

Brad Midgley <bmidgley@gmail.com> wrote:there is no "stable branch" of the kernel in the same way we had before. the module api changes enough from release to release to make it painful to maintain a module outside the kernel. (and don't ask... it will never be merged upstream because it doesn't belong in the kernel) 

 

 
---------------------------------
Finding fabulous fares is fun.
Let Yahoo! FareChase search your favorite travel sites to find flight and hotel bargains.
--0-1357187761-1180970275=:27392
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Ok due to the fact alsa can be configured in or out of the kernel I would assume that the piece of bt that interfaces to it should eventually be in the kernel?<br> Or is the advisement that if you use bt you should seriously consider configuring your alsa modular as opposed to kernel?<br> <br> Will that work better for most people?<br> <br> Thanks.<br> -Walt<br><br><b><i>Brad Midgley &lt;bmidgley@gmail.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;">there is no "stable branch" of the kernel in the same way we had before. the module api changes enough from release to release to make it painful to maintain a module outside the kernel. (and don't ask... it will never be merged upstream because it doesn't belong in the kernel) <br><br> </blockquote><br><p>&#32;

<hr size=1>Finding fabulous fares is fun.<br><a href="http://farechase.yahoo.com/promo-generic-14795097;_ylc=X3oDMTFtNW45amVpBF9TAzk3NDA3NTg5BF9zAzI3MTk0ODEEcG9zAzEEc2VjA21haWx0YWdsaW5lBHNsawNxMS0wNw--
">Let Yahoo! FareChase search your favorite travel sites</a> to find flight and hotel bargains.
--0-1357187761-1180970275=:27392--


--===============1831942022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1831942022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1831942022==--
