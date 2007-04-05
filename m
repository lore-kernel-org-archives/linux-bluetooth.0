Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0704051111x2a26674bx866114aad1bf6f0@mail.gmail.com>
Date: Thu, 5 Apr 2007 15:11:34 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY107-F11C9029CAA2F0071A01144D8650@phx.gbl>
MIME-Version: 1.0
References: <BAY107-F11C9029CAA2F0071A01144D8650@phx.gbl>
Subject: Re: [Bluez-devel] intercept new authentication events
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

On 4/5/07, Adolfo Bulfoni <iaquintovski@hotmail.com> wrote:
> Hi Marcel
> thanks for your quick reply.
>
> I've checked the passkey-agent util program  in /bluez-utils/daemon/ and if
> I try running it, an error message comes up saying there is already a
> passkey agent running on my PC.
> How can I intercept the events sent by this agent? What are the functions
> that need to be called to get the output events from it?
> A "dirty" workaround for my app might be to tail the /var/log/syslog file,
> where the pin_code_request event is logged, together with the remote device
> address. But I'd prefer a cleaner solution.
> Thanks in advance,
> regards
>
> Adolfo
>

Hi Adolfo,

You can develop your own passkey agent. Here is a brief description
how the passkey agent works:
http://wiki.bluez.org/wiki/Security


BR,
Claudio

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
