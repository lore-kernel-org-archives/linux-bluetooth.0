Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Oct 2010 09:56:06 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Automate remote name requests
Message-ID: <20101028135606.GA6909@jh-x301>
References: <1288196742-29386-1-git-send-email-johan.hedberg@gmail.com>
 <AANLkTikKGDtybssKjoNUACAwzg1HA7VC4rWrnNFvJ-2u@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikKGDtybssKjoNUACAwzg1HA7VC4rWrnNFvJ-2u@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Oct 28, 2010, Luiz Augusto von Dentz wrote:
> This seems to be done only for some connections which IMO is not the
> correct, so for instance it wouldn't request name for SDP connections
> nor for incoming connections, is there a reason for that?
> 
> Perhaps requesting the name regardless the security level on
> hci_remote_features_evt and then latter, when we got the name
> response, we continue with security level check and authentication
> request if necessary. Wouldn't that work better?

Yeah, you're right. Basicly what the patch does is replace the
occurences of AUTH_REQ with NAME_REQ and then do the AUTH_REQ in the
name_req_complete callback. However that is not the same as userspace is
doing which is an unconditional name request for every single connect
complete event. FWIW, there seems to be a potential bug with the
existing authentication request too: the code doesn't trigger it if the
extended features request fails (hci_cs_read_remote_ext_features
function).

I'll try to come up with a new revision of the name request patch
shortly.

Johan
