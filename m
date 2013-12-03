Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1385997478-18883-1-git-send-email-szymon.janc@tieto.com>
References: <1385997478-18883-1-git-send-email-szymon.janc@tieto.com>
Date: Tue, 3 Dec 2013 14:10:15 +0200
Message-ID: <CABBYNZLDSE0Ef9--XNdgKEtvDBQGPaqieuDgiiQyKpmFtDKi3A@mail.gmail.com>
Subject: Re: [PATCH] android: Use G_N_ELEMENTS macro for table elements calculation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Dec 2, 2013 at 5:17 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> It is more common in codebase to use this macro instead of opencoded
> (sizeof(foo)/sizeof(foo[0])).
> ---
>  android/a2dp.c      | 2 +-
>  android/bluetooth.c | 2 +-
>  android/hidhost.c   | 2 +-
>  android/main.c      | 2 +-
>  android/pan.c       | 2 +-
>  android/socket.c    | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/android/a2dp.c b/android/a2dp.c
> index 98c138e..cee4bfa 100644
> --- a/android/a2dp.c
> +++ b/android/a2dp.c
> @@ -377,7 +377,7 @@ bool bt_a2dp_register(const bdaddr_t *addr)
>         record_id = rec->handle;
>
>         ipc_register(HAL_SERVICE_ID_A2DP, cmd_handlers,
> -                               sizeof(cmd_handlers)/sizeof(cmd_handlers[0]));
> +                                               G_N_ELEMENTS(cmd_handlers));
>
>         return true;
>  }
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index a39e7bf..6174b1f 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -2418,7 +2418,7 @@ void bt_bluetooth_register(void)
>         DBG("");
>
>         ipc_register(HAL_SERVICE_ID_BLUETOOTH, cmd_handlers,
> -                               sizeof(cmd_handlers)/sizeof(cmd_handlers[0]));
> +                                               G_N_ELEMENTS(cmd_handlers));
>  }
>
>  void bt_bluetooth_unregister(void)
> diff --git a/android/hidhost.c b/android/hidhost.c
> index 38194d0..8bfdfed 100644
> --- a/android/hidhost.c
> +++ b/android/hidhost.c
> @@ -1279,7 +1279,7 @@ bool bt_hid_register(const bdaddr_t *addr)
>         }
>
>         ipc_register(HAL_SERVICE_ID_HIDHOST, cmd_handlers,
> -                               sizeof(cmd_handlers)/sizeof(cmd_handlers[0]));
> +                                               G_N_ELEMENTS(cmd_handlers));
>
>         return true;
>  }
> diff --git a/android/main.c b/android/main.c
> index b9655c5..5210b4b 100644
> --- a/android/main.c
> +++ b/android/main.c
> @@ -430,7 +430,7 @@ int main(int argc, char *argv[])
>         start_sdp_server(0, 0);
>
>         ipc_register(HAL_SERVICE_ID_CORE, cmd_handlers,
> -                               sizeof(cmd_handlers)/sizeof(cmd_handlers[0]));
> +                                               G_N_ELEMENTS(cmd_handlers));
>
>         DBG("Entering main loop");
>
> diff --git a/android/pan.c b/android/pan.c
> index 3270aa4..fe6ee26 100644
> --- a/android/pan.c
> +++ b/android/pan.c
> @@ -322,7 +322,7 @@ bool bt_pan_register(const bdaddr_t *addr)
>         }
>
>         ipc_register(HAL_SERVICE_ID_PAN, cmd_handlers,
> -                               sizeof(cmd_handlers)/sizeof(cmd_handlers[0]));
> +                                               G_N_ELEMENTS(cmd_handlers));
>
>         return true;
>  }
> diff --git a/android/socket.c b/android/socket.c
> index 76b40c8..c9eca44 100644
> --- a/android/socket.c
> +++ b/android/socket.c
> @@ -929,7 +929,7 @@ void bt_socket_register(const bdaddr_t *addr)
>
>         bacpy(&adapter_addr, addr);
>         ipc_register(HAL_SERVICE_ID_SOCK, cmd_handlers,
> -                               sizeof(cmd_handlers)/sizeof(cmd_handlers[0]));
> +                                               G_N_ELEMENTS(cmd_handlers));
>  }
>
>  void bt_socket_unregister(void)
> --
> 1.8.3.2

Applied, thanks.

-- 
Luiz Augusto von Dentz
