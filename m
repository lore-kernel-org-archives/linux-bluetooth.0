Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 Oct 2015 11:11:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/8] emulator: add support for checking le scan state
Message-ID: <20151005081135.GB632@t440s.lan>
References: <1441216275-2954-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441216275-2954-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

(sorry for the late review)

On Wed, Sep 02, 2015, Jakub Pawlowski wrote:
> +const bool hciemu_is_master_le_scan_enabled(struct hciemu *hciemu)
> +{
> +	if (!hciemu || !hciemu->master_dev)
> +		return NULL;
> +
> +	return btdev_is_le_scan_enabled(hciemu->master_dev);
> +}
> +
>  bool hciemu_add_master_post_command_hook(struct hciemu *hciemu,
>  			hciemu_command_func_t function, void *user_data)
>  {
> diff --git a/emulator/hciemu.h b/emulator/hciemu.h
> index 41ca3fc..a526d8c 100644
> --- a/emulator/hciemu.h
> +++ b/emulator/hciemu.h
> @@ -53,6 +53,8 @@ uint8_t *hciemu_get_features(struct hciemu *hciemu);
>  const uint8_t *hciemu_get_master_bdaddr(struct hciemu *hciemu);
>  const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu);
>  
> +const bool hciemu_is_master_le_scan_enabled(struct hciemu *hciemu);

The 'const' doesn't make any sense together with 'bool'. With pointers
it means the data behind the pointer is read-only. It also makes the
patch fail to compile:

In file included from tools/mgmt-tester.c:41:0:
./emulator/hciemu.h:56:11: error: type qualifiers ignored on function return type [-Werror=ignored-qualifiers]
 const bool hciemu_is_master_le_scan_enabled(struct hciemu *hciemu);

Johan
