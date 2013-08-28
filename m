Return-Path: <cyrus@holtmann.org>
Message-ID: <521DCA81.1050102@linux.intel.com>
Date: Wed, 28 Aug 2013 12:01:37 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] sdp: Move sdp server init to adapter
References: <1377522441-28671-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1377522441-28671-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1377522441-28671-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Grzegorz,

On 26/08/2013 15:07, Grzegorz Kolodziejczyk wrote:
> Change-Id: Ie8440d59a00750f3d8aec49924d6b209bc6ebe2f
> ---
>   src/adapter.c |   11 +++++++++++
>   src/adapter.h |    1 +
>   src/main.c    |    2 +-
>   3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 17f5508..723e3a8 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -6295,3 +6295,14 @@ void adapter_shutdown(void)
>   	if (!adapter_remaining)
>   		btd_exit();
>   }
> +
> +void adapter_start_sdp_server(uint16_t sdp_mtu, uint32_t sdp_flags) {

Place opening brace of function at the beginning of the next line, please.

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

