Return-Path: <cyrus@holtmann.org>
Message-ID: <50ABC707.4040200@linux.intel.com>
Date: Tue, 20 Nov 2012 19:08:07 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Reply-To: frederic.dalleau@linux.intel.com
MIME-Version: 1.0
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Implement deferred sco socket setup
References: <1353342958-25303-1-git-send-email-frederic.dalleau@linux.intel.com> <1353342958-25303-3-git-send-email-frederic.dalleau@linux.intel.com> <20121120173734.GG14006@joana> <50ABC41B.8030802@linux.intel.com> <20121120180114.GJ14006@joana>
In-Reply-To: <20121120180114.GJ14006@joana>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 11/20/2012 07:01 PM, Gustavo Padovan wrote:
> * Frédéric Dalleau <frederic.dalleau@linux.intel.com> [2012-11-20 18:55:39 +0100]:
>
>> Hi Gustavo,
>>
>> I'm taking your remarks into account asap
>>
>> On 11/20/2012 06:37 PM, Gustavo Padovan wrote:
>>> Where do you set sk_state to BT_CONNECTED. Doesn't it need to be here?
>> The state is set to BT_CONNECTED in hci_sync_conn_complete_evt. ie when
>> the connection is effectively created.
>
> Are we both talking about the sk_state var? I failed to see how it is set to
> BT_CONNECTED.

Yes, hci_sync_conn_complete_evt > hci_proto_connect_cfm > sco_connect_cfm >

if there is no error, sco_conn_ready.
Since the socket is already created we get in first if branch.

Frédéric
