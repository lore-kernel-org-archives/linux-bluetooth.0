Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 Jul 2010 12:58:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <scarot@libresoft.es>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 16/60] Implement function to send md_reconnect_mdl_req
Message-ID: <20100723095813.GA17429@jh-x301>
References: <1279788733-2324-10-git-send-email-sancane@gmail.com>
 <1279788733-2324-11-git-send-email-sancane@gmail.com>
 <1279788733-2324-12-git-send-email-sancane@gmail.com>
 <1279788733-2324-13-git-send-email-sancane@gmail.com>
 <1279788733-2324-14-git-send-email-sancane@gmail.com>
 <1279788733-2324-15-git-send-email-sancane@gmail.com>
 <1279788733-2324-16-git-send-email-sancane@gmail.com>
 <1279788733-2324-17-git-send-email-sancane@gmail.com>
 <20100722234724.GE2620@vigoh>
 <4C49658D.4090906@libresoft.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C49658D.4090906@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 23, 2010, Santiago Carot-Nemesio wrote:
> >>+static uint8_t *create_req(uint8_t op, uint16_t mdl_id)
> >>+{
> >>+	uint8_t *req;
> >>+	mcap_md_req *req_cmd;
> >>+
> >>+	req = g_malloc0(sizeof(mcap_md_req));
> >>+
> >>+	req_cmd = (mcap_md_req *)req;
> >>+	req_cmd->op = op;
> >>+	req_cmd->mdl = htons(mdl_id);
> >>+
> >>+	return req;
> >>+}
> >Why are you casting here? I would expect  mcap_md_req * as return type
> >here. If the problem is with mcap_send_std_opcode() you can used "void *" as
> >parameter type there.
> >
> I don't see why is better doing it as you say.
> In fact I did it to make the code similar to other bluez modules
> like sdp. You can see the sdp_send_req_w4_rsp and the sdp_send_req
> functions in sdp.c to find similarities with my code.

The SDP code in libbluetooth is probably the absolute worst place to
look for good examples. In this case the second variable in the function
is completely unnecessary. Just assign the malloc return directly to the
mcap_md_req pointer and get rid of the uint8_t* variable.

Btw, I'd like to understand why we should use different acceptance
criteria for your patches compared to everything else that gets
submitted to BlueZ. The convention (which I'm sure you've noticed if you
follow the list) is that when issues are found in submitted patches the
submitter is requested to fix the issue in the patch and resubmit a new
version of the patch. You're essentially requesting for buggy patches to
be accepted as such and only fix the issues through new patches on top
of the buggy ones.

Johan
