Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <a481fbf0709090804h3279547fj763b1a753231465d@mail.gmail.com>
Date: Sun, 9 Sep 2007 11:04:22 -0400
From: "Raymond Ingles" <sorceror171@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <160502.34676.qm@web38502.mail.mud.yahoo.com>
MIME-Version: 1.0
References: <553874.75328.qm@web38513.mail.mud.yahoo.com>
	<160502.34676.qm@web38502.mail.mud.yahoo.com>
Subject: Re: [Bluez-users] Throughput in RFCOMM
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On 9/8/07, Sohel <itsmy_emale@yahoo.com> wrote:
> any comments on my question?? atleast a "yes" or "no".

> Sohel <itsmy_emale@yahoo.com> wrote:

> I have seen that throughput increases with data size in RFCOMM connection.
> Why is it so ??

 I'm not (at all) a Bluez expert, but it could be as simple as the
fact that the larger the chunks of data you're sending, the lower the
overhead. For each chunk of data there's going to be a header
describing the chunk. The more chunks, the more headers; the fewer the
chunks, the fewer the headers.

 If what you're seeing can't be accounted for that way, you'll need to
hope that a real expert chimes in.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
