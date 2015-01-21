Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 Jan 2015 10:05:51 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] mgmt-tester: Fix clang warning
Message-ID: <20150121080548.GA12802@aemeltch-MOBL1>
References: <1421757693-17233-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <6BCE6C2A-2063-40BE-A6EB-8B325992B3CD@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6BCE6C2A-2063-40BE-A6EB-8B325992B3CD@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jan 20, 2015 at 08:12:19AM -0800, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Fixes clang warning below:
> > ...
> > tools/mgmt-tester.c:3805:2: warning: Value stored to 'id' is never read
> >        id = mgmt_register(data->mgmt, MGMT_EV_DISCOVERING,
> > data->mgmt_index,
> >        ^
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 1 warning generated.
> > ...
> > ---
> > tools/mgmt-tester.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> > index 92351e4..295fef5 100644
> > --- a/tools/mgmt-tester.c
> > +++ b/tools/mgmt-tester.c
> > @@ -3802,7 +3802,7 @@ static void setup_start_discovery(const void *test_data)
> > 	uint16_t send_len = test->setup_send_len;
> > 	unsigned int id = 0;
> > 
> > -	id = mgmt_register(data->mgmt, MGMT_EV_DISCOVERING, data->mgmt_index,
> > +	mgmt_register(data->mgmt, MGMT_EV_DISCOVERING, data->mgmt_index,
> > 			   discovering_event, UINT_TO_PTR(id), NULL);
> 
> this this is actually totally broken code. And not in the sense that clang reports it. You are not fixing the problem here. It is just masking the symptom.
> 
> Look into discovering_event callback and see what we do with the UINT_TO_PTR(0) that we are handing in. That code never did what the author was thinking it might do ;)
>

Do you mean we shall use mgmt_unregister_index() instead of
mgmt_unregister() ?

Best regards 
Andrei Emeltchenko 
