Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Nov 2013 09:44:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/2] android/hid: Initial implementation for uHID
Message-ID: <20131101074424.GA3484@x220.p-661hnu-f1>
References: <1383235026-12247-1-git-send-email-luiz.dentz@gmail.com>
 <1383235026-12247-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383235026-12247-2-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz/Ravi,

On Thu, Oct 31, 2013, Luiz Augusto von Dentz wrote:
> From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
> 
> This patch reads data on interrupt channel and feeds into uHID.
> Kernel will take care rest of the things and connects bt mouse
> and keyboard:
> 
> [168988.557647] input: bluez-input-device as /devices/virtual/misc/uhid/input54
> ---
>  android/hid.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 125 insertions(+), 4 deletions(-)

After applying these two patches the tree stops compiling for me (even
after rerunning ./bootstrap-configure):

src/glib-helper.o: In function `bt_modalias':
/home/jh/src/bluez/src/glib-helper.c:42: multiple definition of `bt_modalias'
src/glib-helper.o:/home/jh/src/bluez/src/glib-helper.c:42: first defined here
src/glib-helper.o: In function `bt_uuid2string':
/home/jh/src/bluez/src/glib-helper.c:55: multiple definition of `bt_uuid2string'
src/glib-helper.o:/home/jh/src/bluez/src/glib-helper.c:55: first defined here
src/glib-helper.o: In function `bt_name2string':
/home/jh/src/bluez/src/glib-helper.c:172: multiple definition of `bt_name2string'
src/glib-helper.o:/home/jh/src/bluez/src/glib-helper.c:172: first defined here
src/glib-helper.o: In function `bt_string2uuid':
/home/jh/src/bluez/src/glib-helper.c:202: multiple definition of `bt_string2uuid'
src/glib-helper.o:/home/jh/src/bluez/src/glib-helper.c:202: first defined here
collect2: error: ld returned 1 exit status
make[1]: *** [android/bluetoothd] Error 1

Johan
