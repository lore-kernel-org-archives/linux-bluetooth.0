Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Jul 2011 10:58:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix possible invalid read/free when using
 g_slist_free_full
Message-ID: <20110705075835.GA5086@dell.ger.corp.intel.com>
References: <1309513453-25423-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309513453-25423-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Jul 01, 2011, Luiz Augusto von Dentz wrote:
> This is probably a glib bug on g_slist_free_full which doesn't handle the
> case where the list is modified inside the callback:
> 
>  Invalid read of size 8
>     at 0x50AD5B2: g_slice_free_chain_with_offset (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x13057B: a2dp_unregister (a2dp.c:1550)
>     by 0x12144C: a2dp_server_remove (manager.c:1032)
>     by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x178B55: adapter_remove (adapter.c:2326)
>     by 0x175205: manager_remove_adapter (manager.c:290)
>     by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x50ADF3A: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x175086: manager_cleanup (manager.c:298)
>     by 0x11D7A8: main (main.c:305)
>   Address 0x637a5e8 is 8 bytes inside a block of size 16 free'd
>     at 0x4C27D6E: free (vg_replace_malloc.c:366)
>     by 0x50AD9FC: g_slist_remove (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x12E5C6: a2dp_remove_sep (a2dp.c:1667)
>     by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x50ADF3A: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x13057B: a2dp_unregister (a2dp.c:1550)
>     by 0x12144C: a2dp_server_remove (manager.c:1032)
>     by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x178B55: adapter_remove (adapter.c:2326)
>     by 0x175205: manager_remove_adapter (manager.c:290)
>     by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x50ADF3A: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.2800.8)
> 
>  Invalid free() / delete / delete[]
>     at 0x4C27D6E: free (vg_replace_malloc.c:366)
>     by 0x50AD5A3: g_slice_free_chain_with_offset (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x13057B: a2dp_unregister (a2dp.c:1550)
>     by 0x12144C: a2dp_server_remove (manager.c:1032)
>     by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x178B55: adapter_remove (adapter.c:2326)
>     by 0x175205: manager_remove_adapter (manager.c:290)
>     by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x50ADF3A: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x175086: manager_cleanup (manager.c:298)
>     by 0x11D7A8: main (main.c:305)
>   Address 0x637a5e0 is 0 bytes inside a block of size 16 free'd
>     at 0x4C27D6E: free (vg_replace_malloc.c:366)
>     by 0x50AD9FC: g_slist_remove (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x12E5C6: a2dp_remove_sep (a2dp.c:1667)
>     by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x50ADF3A: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x13057B: a2dp_unregister (a2dp.c:1550)
>     by 0x12144C: a2dp_server_remove (manager.c:1032)
>     by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x178B55: adapter_remove (adapter.c:2326)
>     by 0x175205: manager_remove_adapter (manager.c:290)
>     by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x50ADF3A: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.2800.8)
> 
> Invalid read of size 8
>     at 0x50AD5B2: g_slice_free_chain_with_offset (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x175086: manager_cleanup (manager.c:298)
>     by 0x11D7A8: main (main.c:305)
>   Address 0x62b7ea8 is 8 bytes inside a block of size 16 free'd
>     at 0x4C27D6E: free (vg_replace_malloc.c:366)
>     by 0x50AD9FC: g_slist_remove (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x1751AE: manager_remove_adapter (manager.c:275)
>     by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x50ADF3A: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x175086: manager_cleanup (manager.c:298)
>     by 0x11D7A8: main (main.c:305)
> 
>  Invalid free() / delete / delete[]
>     at 0x4C27D6E: free (vg_replace_malloc.c:366)
>     by 0x50AD5A3: g_slice_free_chain_with_offset (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x175086: manager_cleanup (manager.c:298)
>     by 0x11D7A8: main (main.c:305)
>   Address 0x62b7ea0 is 0 bytes inside a block of size 16 free'd
>     at 0x4C27D6E: free (vg_replace_malloc.c:366)
>     by 0x50AD9FC: g_slist_remove (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x1751AE: manager_remove_adapter (manager.c:275)
>     by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x50ADF3A: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.2800.8)
>     by 0x175086: manager_cleanup (manager.c:298)
>     by 0x11D7A8: main (main.c:305)
> 
> To fix this now adapter_remove and a2dp_unregister_sep are passed
> directly as a callbacks so g_slist_remove is not triggered.
> ---
>  audio/a2dp.c  |   12 ++++++++++--
>  src/manager.c |    5 ++++-
>  2 files changed, 14 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
