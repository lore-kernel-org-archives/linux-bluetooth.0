Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEA8C2D0E7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 18:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798402074D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 18:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3p7T+LX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgCYSVB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:21:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36426 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCYSVA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 14:21:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id s1so2656310lfd.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2020 11:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y5decKnsJFfOQlheUGmgDZ5rqSVWtSszZz5OFJDahM8=;
        b=l3p7T+LXQA7Qv/xyLXu5LHbjqUh4HKYSMrw+ubG4rTj9Fs7KfMayNcC6oBiMtrXYt2
         VRhZRtR7pM3c1BLL1DBaAQrwDg9G3Wh0jyc0bxpcveNIYaIXwfXOcRKEe7PBWVYnzQBo
         EuwIW2u/CuTRrSPUDK5ntaLbFW23xRz/HBY3TmN7ZePa1zaWNyHVdEwbcE58NxSRM66/
         oE+s+EoDcsMr7gpVrUIN3LyE0TR+2z66qJcmj7iXD615AXMvx9ppcZC4wGtIKrXXU40u
         AGXB6dQsvB8hGzMgKiQbKj4SOSJZdwMFXEskd7tZhqb5bAQwZTdFVOkOCqGV8Aeihrdj
         GapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5decKnsJFfOQlheUGmgDZ5rqSVWtSszZz5OFJDahM8=;
        b=HrW2Hk7kmGbaTsoz3G3VeA4xA3H4wdcTScto9wT7QRj/UO5UcV9nhEMi6fqwaOH6FJ
         iWgShgCxNqA7awEItzwk83MOJuGS10E2JqYHrc1x35w35vocHeMTZ8cJqxttzj0MJ7UR
         rG6POaDWGVwhAWuWbqJqtEZW9xjxd3ilqykamK+arKNaUIvEqvR6W0VaxXtPNg6mGXyr
         Z/jHkeoSrnreRY4UVCiEZvPi+wNERu/coSUcBZoKoNKct+P881epj0Ryl2F2pRBtflRq
         VGOc5vjqAVGXfxU/UqYorX6mJSIWsbkAaeSMqT3HGfjvSiB8p5WOKNZA0QIcKom/sL3X
         9wsA==
X-Gm-Message-State: ANhLgQ2PJdndMrsEBcqB6VmhhkNETpIc6vwP2m0i5n8t6fHndZv3kxKe
        1Z4E5eM1cfsTvE3f+F1zSazdqse/4m/ps9uWy38t9CJ/
X-Google-Smtp-Source: ADFU+vuvbN7YP8T2chJFixl4Sx3QQ3U6iIRcP1tU6i42jlRJpQTyJt05kQydkvo0eawNWLHXP6ORu4TVcXCaXLW18QA=
X-Received: by 2002:ac2:43a8:: with SMTP id t8mr3171146lfl.82.1585160456945;
 Wed, 25 Mar 2020 11:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200320133748.154926-1-alainm@chromium.org> <CALWDO_WSHiNw+uwcZzufJ7rjHr=zpMs6f3ry=rdLMGLz2gJZ=w@mail.gmail.com>
 <1ACCF17B-90EB-4DE1-BD8C-A927ABEC3913@holtmann.org> <CALWDO_V=6NXLTZ=XTc+uAe3YUVkUfe88c4beWWoqWK7+vK4+8g@mail.gmail.com>
 <992DB845-DB7F-41B9-93E0-538B08BDF910@holtmann.org> <CALWDO_WF4n_Ta-fYoxTv4OF_guZy=d8urEyrosUPgWdHXo8Pag@mail.gmail.com>
 <C35897C0-9924-4598-859B-0ADD1EF2FB94@holtmann.org> <CALWDO_XjO9=2Y_W-uAXxb+myh1nLvF7_CxrprtLZ=pAj-FrVaQ@mail.gmail.com>
 <1AFDC1E2-8875-4EFC-8A75-DAB89DA9FFB5@holtmann.org> <D1D08F4A-9FAE-4E68-B005-E2573E42D1D8@holtmann.org>
In-Reply-To: <D1D08F4A-9FAE-4E68-B005-E2573E42D1D8@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 25 Mar 2020 14:20:45 -0400
Message-ID: <CALWDO_XU=koYM1BnKeXPBRk+bXV390YMCm0NgwgtspLtox6X_g@mail.gmail.com>
Subject: Re: [PATCH v2] bluetooth: Enforce classic key size verification.
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel.holtmann@intel.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Marcel, that looks good to me.  I agree it's more than the
customer asked for, but it's completely transparent :)

On Wed, Mar 25, 2020 at 2:19 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> >> I suspect we'd want bluetoothd to have a configuration that can enforce a more secure posture.
> >>
> >> Unfortunately when the command isn't supported, the platform is left between a rock and hard place... There isn't much we can do but to block the use of Bluetooth if the platform requires a more secure posture.
> >
> > so if the BR/EDR part is not up to the policy that the host requires, we could still configure the LE part. BlueZ is set up in this way that you can run a dual-mode controller as just a LE controller.
> >
> > I would also opt for the kernel just tells us what options it have. Then at least we can provide some feedback to the end-user on why Bluetooth is not available or why only selected features are available.
>
> what about something like this:
>
> +Read Security Features Command
> +==============================
> +
> +       Command Code:           0x0048
> +       Controller Index:       <controller id>
> +       Command Parameters:
> +       Return Parameters:      Security_Data_Length (2 Octets)
> +                               Security_Data (0-65535 Octets)
> +
> +       This command is used to retrieve the supported security features
> +       by the controller or the kernel.
> +
> +       The Security_Data_Length and Security_Data parameters provide
> +       a list of security settings, features and information. It uses
> +       the same format as EIR_Data, but with the namespace defined here.
> +
> +               Data Type       Name
> +               --------------------
> +               0x01            Flags
> +               0x02            Max Encryption Key Size (BR/EDR)
> +               0x03            Max Encryption Key Size (LE)
> +               0x04            Encryption Key Size enforcement (BR/EDR)
> +               0x05            Encryption Key Size enforcement (LE)
> +               0x06            ECDH Public Key validation (BR/EDR)
> +               0x07            ECDH Public Key validation (LE)
> +
> +
> +       Max Encryption Key Size (BR/EDR and LE)
> +
> +               When the field is present, then it provides 1 Octet value
> +               indicating the max encryption key size. If the field is not
> +               present, then it is unknown what the max encryption key
> +               size of the controller or host is in use.
> +
> +       Encryption Key Size Enforcement (BR/EDR and LE)
> +
> +               When the field is present, then it provides 1 Octet value
> +               indicating the min encryption key size that is enforced by
> +               the controller or host. If the field is not present, then
> +               it is unknown what the controller or host are enforcing.
> +
> +       ECDH Public Key validation (BR/EDR and LE)
> +
> +               When the field is present, then it provides 1 Octet value
> +               indicating if public key validation is in use (0x01) or not
> +               available (0x00). If the field is not present, then it is
> +               unknown if the controller or host are validating public keys.
> +
> +       This command generates a Command Complete event on success or
> +       a Command Status event on failure.
> +
> +       Possible errors:        Invalid Parameters
> +                               Invalid Index
>
> Maybe this is overkill, but it would give us some flexible way of having the kernel tell us what is supported. Then bluetoothd can decide to power a controller or parts of a controller.
>
> Regards
>
> Marcel
>
