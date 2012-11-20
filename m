Return-Path: <cyrus@holtmann.org>
Message-ID: <50ABC41B.8030802@linux.intel.com>
Date: Tue, 20 Nov 2012 18:55:39 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Reply-To: frederic.dalleau@linux.intel.com
MIME-Version: 1.0
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Implement deferred sco socket setup
References: <1353342958-25303-1-git-send-email-frederic.dalleau@linux.intel.com> <1353342958-25303-3-git-send-email-frederic.dalleau@linux.intel.com> <20121120173734.GG14006@joana>
In-Reply-To: <20121120173734.GG14006@joana>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

I'm taking your remarks into account asap

On 11/20/2012 06:37 PM, Gustavo Padovan wrote:
> Where do you set sk_state to BT_CONNECTED. Doesn't it need to be here?
The state is set to BT_CONNECTED in hci_sync_conn_complete_evt. ie when
the connection is effectively created.

My understanding is that BT_CONFIG state indicate the configuration has
been requested, in case recvmsg() is called twice.

Regards,
Frédéric
