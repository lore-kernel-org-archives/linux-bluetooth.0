Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Nov 2013 12:14:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/daemon: Implement get adapter name
Message-ID: <20131104101409.GC2752@x220.p-661hnu-f1>
References: <1383556934-5481-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1383557952-9302-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1383557952-9302-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Nov 04, 2013, Andrei Emeltchenko wrote:
> ---
>  android/adapter.c |   13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

The patch doesn't compile:

android/adapter.c: In function ‘send_adapter_name’:
android/adapter.c:1024:2: error: pointer targets in passing argument 1 of ‘adapter_name_changed’ differ in signedness [-Werror=pointer-sign]
  adapter_name_changed(adapter->name);
  ^
android/adapter.c:145:13: note: expected ‘const uint8_t *’ but argument is of type ‘char *’
 static void adapter_name_changed(const uint8_t *name)
             ^
cc1: all warnings being treated as errors
make[1]: *** [android/adapter.o] Error 1

> @@ -71,6 +71,8 @@ static void mgmt_local_name_changed_event(uint16_t index, uint16_t length,
>  {
>  	const struct mgmt_cp_set_local_name *rp = param;
>  
> +	DBG("");
> +
>  	if (length < sizeof(*rp)) {
>  		error("Wrong size of local name changed parameters");
>  		return;

This change seems unrelated. Just drop it or move it to another patch.

Johan
