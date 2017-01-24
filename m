Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Gix, Brian" <brian.gix@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        Felipe Ferreri Tonello <eu@felipetonello.com>,
        Szymon Janc <szymon.janc@codecoup.pl>
Subject: RE: [PATCH v5 2/2] Make unit test compatible with GLIB v2.28
Date: Tue, 24 Jan 2017 20:10:32 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4372278422C@ORSMSX103.amr.corp.intel.com>
References: <1485287564-16879-1-git-send-email-brian.gix@intel.com>
 <1485287564-16879-3-git-send-email-brian.gix@intel.com>
In-Reply-To: <1485287564-16879-3-git-send-email-brian.gix@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


H Luiz, Felipe, Szymon,

> From: Gix, Brian
> 
> ---
>  unit/test-midi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/unit/test-midi.c b/unit/test-midi.c index d318b07..3995c86 100644
> --- a/unit/test-midi.c
> +++ b/unit/test-midi.c
> @@ -282,8 +282,12 @@ static void compare_events(const snd_seq_event_t
> *ev1,
>  		                ev2->data.control.value);
>  		break;
>  	case SND_SEQ_EVENT_SYSEX:
> -		g_assert_cmpmem(ev1->data.ext.ptr, ev1->data.ext.len,
> -		                ev2->data.ext.ptr, ev2->data.ext.len);
> +		g_assert_cmpint(ev1->data.ext.len,
> +		                ==,
> +		                ev2->data.ext.len);
> +		g_assert(memcmp(ev1->data.ext.ptr,
> +		                ev2->data.ext.ptr,
> +		                ev2->data.ext.len) == 0);
>  		break;
>  	default:
>  		g_assert_not_reached();


Here is a straightforward rework of the g_assert_cmpmem assert.

It was used only once, and both replacement asserts existed pre-v2.28
