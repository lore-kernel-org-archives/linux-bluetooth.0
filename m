Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794933711;
	b=ngg3xGHyWA399yLHntntPm8ZntB+rM4t1JyugO+ZU/fGnP9xJKUeoLnYragbVvei/xVW
	 Fb9R62OBmM/yDFgVpGAaBfmcpqAq80VnY1QH/BDN1eggyPlfa0MO+82VavTH+kZJ4RgI7
	 Pmc4X1IECXZX6FYGG3bmdomrdtOmd+BOKc77Tt9a5Xo9QeBJqN69YuDx4oy+uNQwEtAEn
	 t3iUN9oh0fnDg/Jih2dLUIXK2EeRUFKNJmGvnvy6dpOB8RrUx3w23Ejpyv96D/LwnLWny
	 re7/fr1lxzCqbNKkfhuoo5HczAWgPxZ06MVS4TrHmWY0iRhFtW/PI5czvfpjDzS70xQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=fouY+g4+XUz5Imo+q7GNkKJxfbj+Tc7+8g+q83ty3MA=;
	b=L8/6xZjjLY20CFoZ7wtBb0XA8Eh+qdvuOx+Q3KQDp9T6/34kYEb7FQvChrdFmmhj1q+7
	 REmcz5CgohI0LbmLEEdtthPDyvXKKLB/4nPzEKXSx46zn2x4ZsyiWjpSxEFDbBcQFWZzv
	 L6BjsZGDy4ABraJ2WsR8Iww+J57YR/TdVymeAOFvF+2aDiETeNJ7uxT0BgLeNdBwq9Gm3
	 UHpSG3sHI6UEQB1XuWDLQYY3iabLmUg03Vg5q4Z9JZ3JYL+eK5ZpNFJ8ncMLygFYjn5gr
	 EAAxt28G8RTR0uV5P1ibfirAlHD7MSWYscbMqixBk4jLIpcjwSnLt98fKbGMxC86Heg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UcTbOLqe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BC4606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 16:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2BC4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UcTbOLqe
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67be4f2f4d4so6025256d50.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 08:41:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794933710; cv=none;
        d=google.com; s=arc-20260327;
        b=ZfC9cBTIW3wfSgYjo3a2IcVl2DPHNck5/taCYpZzY7YA2p4Fg8ih3BpqHeg1G61gRg
         FyPQlCcLS6P91y/jR4JzzXbhIMGw9OMryfFg2SY/NaalA1VCESb7LSchEjF0Jz4mVbWZ
         PYu0bwCREyj5fI/7Q2ETGKoLK6q5H5XZ/KdHRfnQUDvUyop1AuU+2tfY52LkchIL3G37
         eCzoqLEr3ebWa0KNwUGZ9kdEb3iPiqgBy9VsR/PDaRqPI/USEPCAx8eRxzept+Q+mgcM
         xVNZYATrnxadEZaqvJa0lobSETR0N5Smf/uS79d6rScaPjzzVqe2H8IgfEcC8Viv2LhD
         0LVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fouY+g4+XUz5Imo+q7GNkKJxfbj+Tc7+8g+q83ty3MA=;
        fh=BP1+C22n99D22J7lCS06XFh4YcH5Wyu18lQrChJ90TM=;
        b=NoHjNFDepPbDAsK7+m9ULuYVuUJ1zO1bmMQf4HoDo6kFsV0yJ8d5jOfN5L7ncH6VqW
         ahfuedJQSBkwwWX+2mFSeq9vrgyLy4wtcp9Rjwf7ZkL/Yz0K8CDvQSlxTE0+49aCF9CR
         Sq/uhODbiB1YN+E0RKKh+cMc9BJBsLkBDL4taRsKHvqaTIL35BapYNoqru4kD0o/xDrc
         hES7UAi13mhrjYmQ0EOoiM1tmZ/4ojZwwpDyKqpkm+E6Jow8hRd0OlE8i9nOUeopuvku
         7MrboekT0yHNluRlAdL24evGOSW6OgQG0dcOInYy9mGT5MZVB1Z1ptAG2ePZfFy8BtSh
         PBcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794933710; x=1795538510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fouY+g4+XUz5Imo+q7GNkKJxfbj+Tc7+8g+q83ty3MA=;
        b=UcTbOLqeojqzbKFN4diTD71wM8GQhfIjmFBcOJEntXud/VnqtzRhV3Mbf0M1rnD+ED
         mnlPTRjmoNsa5+Vrg9aa4ULweIgU0Lu+PFdwzmzPK+XDz+8Z5+XwO+3IEBVyAphuqbeh
         uz6zydKO8cFkBWjPI0w7Aty92NNKUjydunkLBDTm/JP8IgRzEeLMHl2D5F7wmyPobJBU
         XItzilFWR80y4qCd5pGKky9GcvWs1Ejkn2FeectOCLyak3MACjnVOiaOd9dfYvlit4eA
         93f3TQsYbOjKasimBe/eG2SNXO+rcjkRgR+K3/6aGqXcW1wY47b1+AjE67kfe0EslNup
         qX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794933710; x=1795538510;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fouY+g4+XUz5Imo+q7GNkKJxfbj+Tc7+8g+q83ty3MA=;
        b=ZsyUsQced/l7YB0Z1OQF1KHSay3y9kkwfdJc8C24m9pVU3c5yfkDB5dfKF8gpqhcDg
         OLS9pdllBDeIQfK1rUyzIL2uHu5bWlm3OQC8Yfcm5h2KccJ9ZRckCjEy9ahC5LTeD6Om
         pZCPrzQOGb6oXet+GS5U07+qeDCf7KKrIZ5YjgM5nOh9xdCY9hpbdtMUyfPGyAA84o0Y
         KJU1wsnvv7dQEco/bPNgfuxdVAtolbvhmZqnlUoqIqAOGlKqaw8J1VY3ID8w8SqIsVqf
         QPVlCoqQFZiIBjSbCoWDF4mCySU2QKVA/xN6O+i0J056c/qNPUJ4f8uhzMlD8H3qfnMC
         zDIg==
X-Gm-Message-State: APuU4Z/HwvQjiU8gHf+Be/YCb/nBC95tVVORUv7N9dKhdrL3XJpQzZQ5
	8IpjgBQYDNsgOGnWckiC7tTKPDgd6mhJVV04O/U9jQF/kHiLasl0APnQsj7vIeGehq3lgG/dp9S
	iDFDZD89aKBr7WcuaGKud0WDitTO5FMQ=
X-Gm-Gg: AZFdTZdjN7AVHlABWliIo0dj5uIg/groVPtcgzdx3k7yLXMNmB/8/rDYD9HwESvcy83
	BqTFbU3gsm/OHZXl4MLupfWpFLoqmhNJqQZLkc1Eisc0y3NTpq5qQmSNkS2HmpvcYXXGzw/KHg7
	0pAErsyNA25jcV5rJfQvMWeMmdS3YrxP708aY6EnYwMDMYOVYVuvfO4Pck9U2dF4wbnsqcGfO/J
	Tfkl5Da33BcIELv0bQpOevKnKIxqqzeNwtrz97CoXITSPZDoEsXqikxabtpUPCC16JuurAyiN1+
	0WprctWImPKxPheZG/zDdpJ67eLIDCsYkF+tIrIERFaglYS8W0H+LYrg8a+Ynnu72oqi01gdlU3
	4AvW8r0crU9ZTjO0zTZ5Bgfcq3UgeFTeikYGcm7EYNu1sJoyYmyGCU1NF/Nmd0jSND1hne71tbz
	1rju+ty/XxUkwzKDJPIMkEnuCgh4ozAJZYZ0+eNnplCtQ1rrES5Oo3PR5nBg==
X-Received: by 2002:a05:690e:e8c:b0:67d:ac2c:4010 with SMTP id
 956f58d0204a3-67dd40165f4mr28260d50.88.1794933709737; Tue, 17 Nov 2026
 08:41:49 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116090634.1222593-1-jinwang.li@oss.qualcomm.com>
In-Reply-To: <20261116090634.1222593-1-jinwang.li@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 17 Nov 2026 11:41:37 -0500
X-Gm-Features: AclHuK_-1T2RIL0IZ18FRldhez_3mJF2YOFTXQkY9enEfmo5iuayqpg-U4yjFCA
Message-ID: <CABBYNZ+jCVzF9TNjk9EAGiaOfejVcz3g1PNEKGq2Gy6=B-p=pQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 00/20] obexd/pbap: Update PSE support from PBAP
 1.1 to 1.2
To: Jinwang Li <jinwang.li@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com, 
	wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, 
	xiuzhuo.shang@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jinwang,

On Mon, Nov 16, 2026 at 4:06=E2=80=AFAM Jinwang Li <jinwang.li@oss.qualcomm=
.com> wrote:
>
> This series updates the obexd PBAP Phone Book Server Equipment (PSE)
> from PBAP 1.1 to PBAP 1.2, following the PBAP 1.2.3 specification.
>
> It adds PbapSupportedFeatures negotiation, Database Identifier and
> primary and secondary Folder Version Counter response parameters, and
> vCardSelector filtering for phonebook and vCard listing requests. It
> also advertises Contact Image Default Format and updates the SDP profile
> version to 0x0102.
>
> The dummy backend persists the Database Identifier and folder counters.
> The ebook and Tracker backends report zero values to indicate that these
> values are not persistent. vCardSelector is implemented in all three
> backends.
>
> The series also fixes phonebook backend and request handling issues,
> refreshes the listing cache for each request, and adds NewMissedCalls to
> vCard listing responses. NewMissedCalls is limited to mch responses.
>
> Testing was performed on the OE-Core wrynose branch (Yocto Project 6.0),
> together with prerequisite patches already merged upstream. The dummy,
> ebook, and Tracker backends were all functionally tested. The dummy
> backend was also tested against the PBAP PSE PTS test cases covered by
> this series.
>
> Changes in v3:
>  - Rebased the series.
>  - Patch 6: Shorten the subject without changing functionality.
>  - Patch 7: Preserve quoted-printable PHOTO continuations and correctly
>    parse quoted parameter values while filtering unselected photos.
>  - Patch 16: Associate persisted metadata with each virtual phonebook
>    folder and reject incomplete folder scans when computing digests.
>  - Patch 17: Move folder-specific metadata handling into patch 16. Keep
>    this response patch limited to emitting negotiated counters.
>  - Patch 18: Apply vCardSelector when calculating a PullPhoneBook size
>    response with MaxListCount set to zero.
>  - Patch 19: Handle folded headers, quoted parameter values, and
>    quoted-printable continuations when validating default-format photos.
>    Clarify that returned photos must use the PBAP default image format.
>  - V2 link:
>    https://lore.kernel.org/all/20261111094425.1444893-1-jinwang.li@oss.qu=
alcomm.com/
>
> Changes in v2:
>  - Rebased the patch.
>  - Patches 1-2: Add the PRODID fixes.
>  - Patch 7: Also remove the unindented BASE64 body of an unselected
>    PHOTO property from dummy backend responses.
>  - Patch 16: Do not refresh the folder version counters for
>    PullvCardEntry.
>  - Patch 18: Use PRODID in the vCardSelector property table.
>  - Patch 19: Send only PHOTO properties that are BASE64 encoded JPEG
>    images of at most 300x300 pixels and 50 KiB.
>  - V1 link:
>    https://lore.kernel.org/all/20261104083429.4111632-1-jinwang.li@oss.qu=
alcomm.com/
>
> Jinwang Li (20):
>   obexd/pbap: Fix PRODID property name
>   doc: Fix PRODID property name
>   obexd/pbap: Fix crash counting vCards in dummy backend
>   obexd/pbap: Fix Tracker contact grouping across requests
>   obexd/pbap: Include directly bound Tracker telephone numbers
>   obexd/pbap: Reject listing without Name in telecom folder
>   obexd/pbap: Fix unselected PHOTO in dummy responses
>   obexd/pbap: Refresh cache for each vCard listing
>   obexd/pbap: Limit NewMissedCalls to mch responses
>   obexd/pbap: Add NewMissedCalls to vCard listing responses
>   obexd/pbap: Separate vCard entry response handling
>   obexd: Parse application parameters in CONNECT request
>   obexd/pbap: Parse PbapSupportedFeatures in connect request
>   obexd/pbap: Add persistent database identifier
>   obexd/pbap: Include database identifier in responses
>   obexd/pbap: Add folder version counters
>   obexd/pbap: Include folder version counters in responses
>   obexd/pbap: Add vCardSelector support
>   obexd/pbap: Support Contact Image Default Format
>   profile: Update PBAP PSE version and features
>
>  Makefile.obexd                         |   2 +
>  doc/org.bluez.obex.PhonebookAccess.rst |   2 +-
>  obexd/client/pbap.c                    |   2 +-
>  obexd/plugins/pbap.c                   | 778 +++++++++++++++++++++++--
>  obexd/plugins/phonebook-dummy.c        | 745 +++++++++++++++++++++--
>  obexd/plugins/phonebook-ebook.c        |  88 ++-
>  obexd/plugins/phonebook-metadata.c     | 257 ++++++++
>  obexd/plugins/phonebook-metadata.h     |  52 ++
>  obexd/plugins/phonebook-tracker.c      | 367 +++++++-----
>  obexd/plugins/phonebook.c              |   8 +
>  obexd/plugins/phonebook.h              |  84 ++-
>  obexd/plugins/vcard.c                  |  71 ++-
>  obexd/plugins/vcard.h                  |   2 +
>  obexd/src/obex.c                       |  42 +-
>  src/profile.c                          |   4 +-
>  15 files changed, 2209 insertions(+), 295 deletions(-)
>  create mode 100644 obexd/plugins/phonebook-metadata.c
>  create mode 100644 obexd/plugins/phonebook-metadata.h
>
> --
> 2.34.1

Copilot flagged 2 problems:

https://github.com/bluez/bluez/pull/2833#pullrequestreview-5942549908

--=20
Luiz Augusto von Dentz
