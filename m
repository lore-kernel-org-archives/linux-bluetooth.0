Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Sep 2012 12:57:57 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Subject: Re: [PATCHv4 11/17] Bluetooth: Choose connection based on
 capabilities
Message-ID: <20120914095756.GF7483@aemeltch-MOBL1>
References: <alpine.DEB.2.02.1209111121550.3754@mathewm-linux>
 <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1347437192-24694-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1209130916550.19321@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1209130916550.19321@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Sep 13, 2012 at 09:26:27AM -0700, Mat Martineau wrote:

...

> >+static void l2cap_choose_conn(struct l2cap_chan *chan)
> 
> I find this function name a little confusing - "choose" sounds like
> it is just making a decision.  This function also takes the action
> of starting physical link setup or sending a connection request,
> which is more than just "choosing".
> 
> l2cap_start_connection, maybe?

Sounds good to me. Will change.

Best regards 
Andrei Emeltchenko 

