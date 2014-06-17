Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v4 0/4] bt_att initial implementation
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402958640-1132-1-git-send-email-armansito@chromium.org>
Date: Tue, 17 Jun 2014 11:33:31 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <030E0E9C-9084-4DFF-BF5D-485AEF849723@holtmann.org>
References: <1402958640-1132-1-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> v4:
>  - Changed get_op_type from a big switch statement to a function that walks a
>  static const array that represents a table of ATT opcodes and their types.
>  - Single bt_att_register function for incoming requests and notifications/
>  indications.
>  - Replaced bt_att_set_auth_signature with bt_att_set_signing_data, which takes
>  in the CSRK and the sign counters, which will be used to generate the
>  authentication signature for outgoing signed PDUs and to verify incoming
>  signed PDUs.
>  - Added bt_att_set_timeout_cb. Added a 30 second timeout for pending requests,
>  after which the user will be notified and bt_att invalidated.
>  - Moved parameter structure, opcode, and error code definitions to
>  src/shared/att-types.h

so besides minor cosmetic changes and leaving the CSRK detail our for now, this looks good.

Johan, Luiz, have an extra look, but I think v5 should be ready to be merged.

Regards

Marcel

