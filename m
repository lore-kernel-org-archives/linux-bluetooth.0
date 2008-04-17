Return-Path: <cyrus@holtmann.org>
Message-ID: <f9d4bd30804171342y785e7b00tf3e311a1a400813@mail.gmail.com>
Date: Thu, 17 Apr 2008 17:42:15 -0300
From: "Claudio Takahasi" <claudio.takahasi@openbossa.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <6B304E64-DFCE-412F-AB4C-7D923E1606D9@holtmann.org>
MIME-Version: 1.0
References: <48075B6A.2060308@access-company.com>
	<2d5a2c100804171117r3101afddgeb31e9735f71c0b6@mail.gmail.com>
	<6B304E64-DFCE-412F-AB4C-7D923E1606D9@holtmann.org>
Subject: Re: [Bluez-devel] [patch] BNEP/PAN Qualification issues
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

On Thu, Apr 17, 2008 at 3:26 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>
>  > pand is deprecated so it should be good if you can take a look in
>  > network plugin and see if it surfer from the same problems.
>
>  both share the kernel layer. So we have to fix that part first.
>
>  Regards
>
>  Marcel
>
>
>
>
>  -------------------------------------------------------------------------
>  This SF.net email is sponsored by the 2008 JavaOne(SM) Conference
>  Don't miss this year's exciting event. There's still time to save $100.
>  Use priority code J8TL2D2.
>  http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
>  _______________________________________________
>  Bluez-devel mailing list
>  Bluez-devel@lists.sourceforge.net
>  https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

Hi,

Does it make sense validate the source and destination uuid in the kernel?

We also need to decode the setup connection request message and reply
an error when the server is not enabled. Suppose that PANU and GN are
enabled and NAP is disabled. If destination requested is NAP the
response message should be not allowed, correct?

Another point, it is necessary check source/destination role
combination. For example: GN <->GN, NAP<->NAP, GN<->NAP must be
rejected.

Regards,
Claudio.

-- 
--
Claudio Takahasi
Instituto Nokia de Tecnologia
Recife - Pernambuco - Brasil
+55 81 30879999

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
