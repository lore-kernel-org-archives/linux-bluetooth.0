Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 16 Nov 2006 16:12:19 +0100
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20061116151219.GP22267@suse.de>
References: <7e36c64c0611160249k1d84be38mac24337684b768ea@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <7e36c64c0611160249k1d84be38mac24337684b768ea@mail.gmail.com>
Subject: Re: [Bluez-devel] Dongle address
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Thu, Nov 16, 2006 at 04:19:08PM +0530, shantibhushan sale wrote:
> Hi,
>  I have a  dongle with BD address 11:11:11:11:11:11.I m not able to
> register my server for obex connection.
>       BtOBEX_ServerRegister(handle, BDADDR_ANY, channel);
> =

> This gets failed....What is the problem

The address is invalid. Return that dongle and claim your money back.
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
