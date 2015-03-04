Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Mar 2015 21:58:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 2/3] Bluetooth: Refactor service discovery filter logic
Message-ID: <20150304195850.GA9535@t440s.P-661HNU-F1>
References: <1425406613-21420-1-git-send-email-jpawlowski@google.com>
 <1425406613-21420-2-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425406613-21420-2-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tue, Mar 03, 2015, Jakub Pawlowski wrote:
> +		if (hdev->discovery.uuid_count != 0 &&
> +		    (eir_len == 0 || !eir_has_uuids(eir, eir_len,
> +				  hdev->discovery.uuid_count,
> +				  hdev->discovery.uuids)) &&
> +		    (scan_rsp_len == 0 || !eir_has_uuids(scan_rsp, scan_rsp_len,
> +				  hdev->discovery.uuid_count,
> +				  hdev->discovery.uuids)))
> +			return;

This if-statement needs to be simplified somehow, or split up, since
right now it looks just too complex. You should at least be able to
remove the '== 0' comparisons since eir_has_uuids() will directly return
false then.

Other than this I haven't found any other major issues with this set.

One thing you might wanna consider is to do a bit more refactoring of
this new big if-branch (i.e. move the content of it to separate
function). This is something that can be done as an additional patch on
top of this set. I realize the mgmt_device_found() is suffering of being
quite complex already before your patches, but having the filtered_scan
case now in a single branch opens the door to factoring it out into a
separate function. As a bonus you'll also get a bit better readability
due to having one less tab for indentation, i.e. not as frequent forced
line breaks.

Johan
