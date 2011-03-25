Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110325161532.GA9649@jh-x301>
References: <1301059143-14614-1-git-send-email-sancane@gmail.com>
	<20110325133237.GA6600@jh-x301>
	<AANLkTimEenNDyt3Q6wSoeqiA83hQ4Xth=2dUTf1J9knH@mail.gmail.com>
	<20110325161532.GA9649@jh-x301>
Date: Fri, 25 Mar 2011 17:46:37 +0100
Message-ID: <AANLkTikNNc6E-H3xs7wa5Ro2cxCYBDmY-kM6N2sU41RP@mail.gmail.com>
Subject: Re: [PATCH] Emit missing signal when data channel is reconnected.
From: Santiago Carot <sancane@gmail.com>
To: Santiago Carot <sancane@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2011/3/25 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi,
>
> On Fri, Mar 25, 2011, Santiago Carot wrote:
>> >> diff --git a/health/hdp.c b/health/hdp.c
>> >> index 3c2dce1..b06fe17 100644
>> >> --- a/health/hdp.c
>> >> +++ b/health/hdp.c
>> >> @@ -510,14 +510,23 @@ static void hdp_mdl_reconn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
>> >>       }
>> >>
>> >>       fd = mcap_mdl_get_fd(dc_data->hdp_chann->mdl);
>> >> -     if (fd < 0)
>> >> +     if (fd < 0) {
>> >>               reply = g_dbus_create_error(dc_data->msg,
>> >>                                               ERROR_INTERFACE ".HealthError",
>> >>                                               "Cannot get file descriptor");
>> >> +             g_dbus_send_message(dc_data->conn, reply);
>> >> +             return;
>> >> +     }
>> >>
>>
>> This is not a memory leak fix, if fd is less than 0, then reconnection
>> was not succesfully and then we reply with an error response to the
>> application but we dont not emit the CahnnelConnected signal. (return
>> statement).
>
> The code (before your patch) was assigning a value to reply and then
> right afterwards assigning another value to it without freeing it in
> between:
>
>> >>       reply = g_dbus_create_reply(dc_data->msg, DBUS_TYPE_UNIX_FD, &fd,
>> >>                                                       DBUS_TYPE_INVALID);
>
> How is that not a memory leak? (not to mention that g_dbus_send_message
> isn't called to the error message that you create). Looks to me like
> there was an "else" statement missing or something similar.
>

Sorry,
I didn't understood what you meant. I though that you was referring to
the pach but you was referring to the old code. Now I see.
You are right, I'm going to split it in two patches right away.
