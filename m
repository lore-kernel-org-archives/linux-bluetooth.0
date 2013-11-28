Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 2/2] gitignore: Add tools/avdtp-tester
Date: Thu, 28 Nov 2013 12:31:06 +0100
Message-ID: <1539320.U5BoN7FQQq@uw000953>
In-Reply-To: <CAJdJm_P_mho-QXy_Gfpqqps1b5cM0AuVKp30=EQCrVzuNLGSVQ@mail.gmail.com>
References: <1385637056-561-1-git-send-email-szymon.janc@tieto.com> <1385637056-561-2-git-send-email-szymon.janc@tieto.com> <CAJdJm_P_mho-QXy_Gfpqqps1b5cM0AuVKp30=EQCrVzuNLGSVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> Hi Szymon,
> 
> On Thu, Nov 28, 2013 at 7:10 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> > ---
> >  .gitignore | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/.gitignore b/.gitignore
> > index d567d26..2d3435a 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -100,6 +100,7 @@ unit/test-gobex-apparam
> >  unit/test-gobex-header
> >  unit/test-gobex-packet
> >  unit/test-gobex-transfer
> > +unit/test-avdtp
> >  unit/test-*.log
> >  unit/test-*.trs
> 
> The tool name on the commit description is incorrect.

Ahh right, copy-paste error :) will send v2

-- 
BR
Szymon

