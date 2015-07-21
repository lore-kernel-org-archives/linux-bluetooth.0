Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Jul 2015 06:22:01 -0700 (PDT)
From: Szymon Janc <szymon.janc@tieto.com>
To: Anupam Roy <anupam.r@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/client/if-hl.c:Handle failure from malloc() request
Message-ID: <1920962.6CvK0I8IiL@leonov>
In-Reply-To: <1437483677-9793-1-git-send-email-anupam.r@samsung.com>
References: <1437483677-9793-1-git-send-email-anupam.r@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anupam,

On Tuesday 21 of July 2015 09:01:17 Anupam Roy wrote:
> Ping

I looks like I never got the original patch. Could you resend it?
(seems like you hit timeframe when my gmail was experiencing issues with vger 
server and I had to resubscribe to mailing list)

> > -----Original Message-----
> >
> >From: Anupam Roy <anupam.r@samsung.com>
> >To: linux-bluetooth@vger.kernel.org
> >Cc:sachin.dev@samsung.com; anupam.r@samsung.com
> >Date : Jun 23, 2015 21:04 (GMT+09:00)
> >Title : [PATCH] android/client/if-hl.c:Handle failure from malloc() request
> >
> >
> >In case malloc() request fails, just print error message
> >and return. Dereferencing reg.mdep_cfg in case of failure
> >can lead to crash.
> >---
> >
> > android/client/if-hl.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> >
> >diff --git a/android/client/if-hl.c b/android/client/if-hl.c
> >index e0818ba..bd05671 100644
> >--- a/android/client/if-hl.c
> >+++ b/android/client/if-hl.c
> >@@ -201,6 +201,10 @@ static void register_application_p(int argc, const
> >char **argv)>
> > 	reg.number_of_mdeps = atoi(argv[6]);
> > 	
> > 	reg.mdep_cfg = malloc(reg.number_of_mdeps * sizeof(bthl_mdep_cfg_t));
> >
> >+	if (!reg.mdep_cfg) {
> >+		haltest_error("malloc failed\n");
> >+		return;
> >+	}
> >
> > 	mdep_argc_init = 7;
> > 	
> > 	for (i = 0; i < reg.number_of_mdeps; i++) {
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
BR
Szymon Janc
