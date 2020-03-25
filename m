Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419E3C2D0E5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 18:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D3F2074D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 18:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgCYSTE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:19:04 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38714 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgCYSTE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 14:19:04 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 29E30CECD4;
        Wed, 25 Mar 2020 19:28:35 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v2] bluetooth: Enforce classic key size verification.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1AFDC1E2-8875-4EFC-8A75-DAB89DA9FFB5@holtmann.org>
Date:   Wed, 25 Mar 2020 19:19:02 +0100
Cc:     Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel.holtmann@intel.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D1D08F4A-9FAE-4E68-B005-E2573E42D1D8@holtmann.org>
References: <20200320133748.154926-1-alainm@chromium.org>
 <CALWDO_WSHiNw+uwcZzufJ7rjHr=zpMs6f3ry=rdLMGLz2gJZ=w@mail.gmail.com>
 <1ACCF17B-90EB-4DE1-BD8C-A927ABEC3913@holtmann.org>
 <CALWDO_V=6NXLTZ=XTc+uAe3YUVkUfe88c4beWWoqWK7+vK4+8g@mail.gmail.com>
 <992DB845-DB7F-41B9-93E0-538B08BDF910@holtmann.org>
 <CALWDO_WF4n_Ta-fYoxTv4OF_guZy=d8urEyrosUPgWdHXo8Pag@mail.gmail.com>
 <C35897C0-9924-4598-859B-0ADD1EF2FB94@holtmann.org>
 <CALWDO_XjO9=2Y_W-uAXxb+myh1nLvF7_CxrprtLZ=pAj-FrVaQ@mail.gmail.com>
 <1AFDC1E2-8875-4EFC-8A75-DAB89DA9FFB5@holtmann.org>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

>> I suspect we'd want bluetoothd to have a configuration that can enforce a more secure posture.
>> 
>> Unfortunately when the command isn't supported, the platform is left between a rock and hard place... There isn't much we can do but to block the use of Bluetooth if the platform requires a more secure posture.
> 
> so if the BR/EDR part is not up to the policy that the host requires, we could still configure the LE part. BlueZ is set up in this way that you can run a dual-mode controller as just a LE controller.
> 
> I would also opt for the kernel just tells us what options it have. Then at least we can provide some feedback to the end-user on why Bluetooth is not available or why only selected features are available.

what about something like this:

+Read Security Features Command
+==============================
+
+       Command Code:           0x0048
+       Controller Index:       <controller id>
+       Command Parameters:
+       Return Parameters:      Security_Data_Length (2 Octets)
+                               Security_Data (0-65535 Octets)
+
+       This command is used to retrieve the supported security features
+       by the controller or the kernel.
+
+       The Security_Data_Length and Security_Data parameters provide
+       a list of security settings, features and information. It uses
+       the same format as EIR_Data, but with the namespace defined here.
+
+               Data Type       Name
+               --------------------
+               0x01            Flags
+               0x02            Max Encryption Key Size (BR/EDR)
+               0x03            Max Encryption Key Size (LE)
+               0x04            Encryption Key Size enforcement (BR/EDR)
+               0x05            Encryption Key Size enforcement (LE)
+               0x06            ECDH Public Key validation (BR/EDR)
+               0x07            ECDH Public Key validation (LE)
+
+
+       Max Encryption Key Size (BR/EDR and LE)
+
+               When the field is present, then it provides 1 Octet value
+               indicating the max encryption key size. If the field is not
+               present, then it is unknown what the max encryption key
+               size of the controller or host is in use.
+
+       Encryption Key Size Enforcement (BR/EDR and LE)
+
+               When the field is present, then it provides 1 Octet value
+               indicating the min encryption key size that is enforced by
+               the controller or host. If the field is not present, then
+               it is unknown what the controller or host are enforcing.
+
+       ECDH Public Key validation (BR/EDR and LE)
+
+               When the field is present, then it provides 1 Octet value
+               indicating if public key validation is in use (0x01) or not
+               available (0x00). If the field is not present, then it is
+               unknown if the controller or host are validating public keys.
+
+       This command generates a Command Complete event on success or
+       a Command Status event on failure.
+
+       Possible errors:        Invalid Parameters
+                               Invalid Index

Maybe this is overkill, but it would give us some flexible way of having the kernel tell us what is supported. Then bluetoothd can decide to power a controller or parts of a controller.

Regards

Marcel

