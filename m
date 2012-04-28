Return-Path: <cyrus@holtmann.org>
Date: Sat, 28 Apr 2012 13:13:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mike <puffy.taco@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: TP/SIG/SMG/BI-02-C failure
Message-ID: <20120428101311.GA9270@x220.P-661HNU-F1>
References: <CAB7rCTiT6m368AReu0mbVVp+Ptc9frQLXp+AvsOY8csyKiVEhg@mail.gmail.com>
 <20120428095617.GA7550@x220.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120428095617.GA7550@x220.P-661HNU-F1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Apr 28, 2012, Johan Hedberg wrote:
> > For those who are more familiar with the position of
> > "remove_disconnect_timer(session);" in session_cb, does it make sense
> > to move that outside the AVDTP_MSG_TYPE_COMMAND block so that even the
> > invalid discover command (general reject) turns off the timer?
> 
> The timer is only removed if there are no streams present

Sorry, that should say "if there *are* streams present":

                if (session->streams && session->dc_timer)
                        remove_disconnect_timer(session);

Johan
