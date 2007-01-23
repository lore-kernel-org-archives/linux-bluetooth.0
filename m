Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d23110170701231315p7a32e9f3w57a2db4260f0529c@mail.gmail.com>
Date: Tue, 23 Jan 2007 18:15:13 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <be976db60701230742m39c586c3sc7c37ec691631ed0@mail.gmail.com>
MIME-Version: 1.0
References: <be976db60701230742m39c586c3sc7c37ec691631ed0@mail.gmail.com>
Subject: Re: [Bluez-devel] checking RFCOMM status
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On 1/23/07, Mark S. Townsley <mstownsley@gmail.com> wrote:
>  Is there any way I can get the status of an RFCOMM socket connection to
> detect whether it is still alive or it has been disconnected somehow?  In my
> application (in C++), I need to stay on top of the status of the RFCOMM
> connection and do something if it is no longer active for some reasons

You can use select() or poll() on the socket to know which events occurred.

-- Ulisses

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
