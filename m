Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0611300428u732bd2bdj6692e6aa2a85c7b4@mail.gmail.com>
Date: Thu, 30 Nov 2006 09:28:38 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <be976db60611291450t78556986s801891c24f0dff7c@mail.gmail.com>
MIME-Version: 1.0
References: <be976db60611291450t78556986s801891c24f0dff7c@mail.gmail.com>
Subject: Re: [Bluez-users] sdp service name
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On 11/29/06, Mark S. Townsley <mstownsley@gmail.com> wrote:
> Hi:
>
> I am looking into how to use sdptool to add "sp" service but name it as
> "PWAccessP".
> I can add "sp" but cannot figure out how to change the name to PWAccessP.
> I have a device that searches for an "sp" service with that name.
>
> Thanks in advance for any tips/pointers.
>
> mark
>

Hi Mark,

Check the functions "add_sp"(utils/tools/sdptool.c) and
"sdp_set_info_attr" "libs/src/sdp.c)

Claudio.

-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
