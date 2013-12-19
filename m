Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Dec 2013 16:42:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] android/tester: Fix for not checking for
 BT_STATUS_SUCCESS
Message-ID: <20131219144222.GA11811@x220.p-661hnu-f1>
References: <1387456946-9743-1-git-send-email-jakub.tyszkowski@tieto.com>
 <20131219134224.GA23417@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131219134224.GA23417@x220.p-661hnu-f1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Dec 19, 2013, Johan Hedberg wrote:
> On Thu, Dec 19, 2013, Jakub Tyszkowski wrote:
> > For BT_STATUS_SUCCESS no checks were done as it is 0 in bt_status_t
> > enum. Valid status for no status expected should be STATUS_NOT_EXPECTED.
> > 
> > ---
> >  android/android-tester.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/android/android-tester.c b/android/android-tester.c
> > index c24f5a6..5549dcb 100644
> > --- a/android/android-tester.c
> > +++ b/android/android-tester.c
> > @@ -72,7 +72,7 @@ enum hal_bluetooth_callbacks_id {
> >  };
> >  
> >  struct generic_data {
> > -	uint8_t expected_adapter_status;
> > +	int expected_adapter_status;
> >  	uint32_t expect_settings_set;
> >  	bt_property_t expected_property;
> >  	uint8_t expected_hal_callbacks[];
> > @@ -92,6 +92,8 @@ struct socket_data {
> >  #define WAIT_FOR_SIGNAL_TIME 2 /* in seconds */
> >  #define EMULATOR_SIGNAL "emulator_started"
> >  
> > +#define BT_STATUS_NOT_EXPECTED	-1
> > +
> >  struct test_data {
> >  	struct mgmt *mgmt;
> >  	uint16_t mgmt_index;
> > @@ -199,7 +201,7 @@ static void expected_status_init(struct test_data *data)
> >  {
> >  	const struct generic_data *test_data = data->test_data;
> >  
> > -	if (!(test_data->expected_adapter_status))
> > +	if (test_data->expected_adapter_status == BT_STATUS_NOT_EXPECTED)
> >  		data->status_checked = true;
> >  }
> 
> I suppose it does make sense to have such a special value, but I can't
> see you use it anywhere in your patch set. So I'd postpone this patch
> until you've got some actual code that needs it.

Nevermind. I now see that even though you don't add any tests that would
use this new value the change of the if-statement that this patch
introduces is already enough of a justification.

All patches in the set have now been applied.

Johan
