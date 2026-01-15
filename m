Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE5A7E110
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 02:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768444176; cv=none; b=ABkFjwvdFu5oFjz7Gi4p8YUllisaZ/5NxUmt22lezYLTcIQtrsNxLHsC0BG9DTSx9Sx7cLp5z/x/4it3dgOZKwDzcrnZF+sSi2IS4/Uihopv61MJqRb/La+0Xp7DSYJ5T9Xbsxz873QLBU9cnF5WMAId/3aEAOkRgoDYTVcJX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768444176; c=relaxed/simple;
	bh=UZ1dpQctMhlXK5jZJXx5zthz3qa6d2MHzKgHvIC/E14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uuu1mei7Zi+yF+AJsMB9Dq0om2pbfkXLyVR9yKMvZarSnN/Z4cOCAO3bXvxNxLpgCiXfWI92bhm2QRp+EF/8sSJiBWg5Pcnyk4UA4U+G0dSlgp3K17tNaXj5XYXz2qgjblnDzDSwQaFb3vTCQsA15h4pat1nb5YRUa9TssrA1ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LXBLrfKe; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LXBLrfKe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rYZEPM+bqulvUIVLPh45VUiOhekdLtEE0Z6fqD06ja8=; b=LXBLrfKenPG6tziVQ5iz8xC3Cu
	6Mu3YL/8bOrqeK75mbhAyo/5kI+VH+s2V01iepKBm7AbcFeLsDpnGbEYt5V96DRi25FtgYLECHShY
	CMPRn7FhtqFBTha5NIZQa+4/XofWo/p6AGRikpzgfeeERss2jVbsl62wYA/bct9bWrFQ1+KhsYGXL
	wOUZUsCWk+FCLW+FIzbqG/zwFjt/NczfJl3m2uEgrt/m57tN1hHzRqBWlv9ZsuoTTU+yLDi8j3C8S
	uXt6NE1UCaQOjRVuDYs+RpO9hP4o3LlHePttOxXQjW1ZAHzxf7275q2/1IzDzUCYP65ojSOT//EsK
	6X9+PMIg==;
Received: from 205.red-83-35-235.dynamicip.rima-tde.net ([83.35.235.205] helo=breogan.igalia.local)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vgD74-005YTj-8y; Thu, 15 Jan 2026 03:29:30 +0100
From: "Manuel A. Fernandez Montecelo" <mafm@igalia.com>
To: linux-bluetooth@vger.kernel.org
Cc: "Manuel A. Fernandez Montecelo" <mafm@igalia.com>
Subject: [PATCH BlueZ v3 0/1] Support for config fragments (conf.d style dirs)
Date: Thu, 15 Jan 2026 03:28:51 +0100
Message-ID: <20260115022852.2841362-1-mafm@igalia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support config fragments, to read config from conf.d directories.

This is commonly supported by other tools, as an extension of the main
config file(s).  It is useful and convenient in several situations,
for example:

* distributions can set different values from the defaults shipped
  upstream, without having to modify the config file

* different packages or config-management tools can change config just
  by adding, removing or modifying files in that directory; instead of
  editing the main config files

---
Notes on v3 non-changes:

I considered other changes for v3 as requested in message
https://marc.info/?l=linux-bluetooth&m=176557679130526 , but as
explained in my next reply
(https://marc.info/?l=linux-bluetooth&m=176558570102172&w=2), I didn't
understand part of the request, so in the meantime I tried my best to
interpret, to make some progress.

Experimenting and pondering for quite a while about the question of how
to do the loading and parsing (as discussed in those messages), I came
to the conclusion that in general it makes sense to keep the main idea
of this patches' implementation:
* to consider the config fragments (files in conf.d) part of the config
  in each area (an extension of main.conf, input.conf, etc);
* treat the whole set as a single unit, loading base and then one
  fragment after another in place for that area (which means also
  parsing the config file in text to convert it to a key_file in mem);
* and only after an area is complete and all bits are in, invoke
  parse_config(main_conf)-like functions to transfer values to code
  variables, and do it only once.

Problems mentioned in the message, like wrong groups in the base
main.conf being then possible in the fragments, should not have a bad
effect in practice -- there are specific checks with hardcoded "valid
groups" and "keys" for each area.  And if the values of the keys
overriden are not valid, it will also be noticed later in the
processing.

Another problem, perhaps more theoretical (I don't think that it will
have much impact in the real-world, but nevertheless somewhat wasteful
effort), is to do the loading and parsing over and over.
parse_config()-like functions are trying to find values for all possible
keys, that in case of fragments typically do not exist -- because
fragments typically only contain one, or perhaps a handful of key=values
only.  As I see it, the pre-existing code is based on the idea that the
key_file representing each section (main.conf, input.conf, etc) contains
all the config for that area, and it only loads and parses once each
area.

As an additional, more practical problem, for example main.conf (as
represented in a key_file) is preserved for the whole lifetime of the
program running, and there's the function:
  GKeyFile *btd_get_main_conf(void) {
          return main_conf;
  }

Then plugins/policy.c invokes this function and acts upon the values.  I
think that the returned value of that function should include the extra
config fragments, and not only exclusively the representation of the
original main.conf file, both in theoretical terms but also in practice
-- because otherwise this policy.c would not be able to act upon config
coming via fragments.

So, all in all, I think that merging all loaded config in a single
key_file, and then transferring those values to program variables only
once, is roughly the correct approach.

But I'm completely open to change it if you are still not convinced or
see other problems of this approach.  And please clarify your previous
message if I misunderstood.

---
Changes in v3:
- Minor rephrasing of commit message, fixing conf paths and others
- Emit DBG message if network.conf fails to parse (silently ignored now)
- Add err parameter to confd_process_config(), modify returned message
  to include file that fails to parse, and check returned errors from
  calling sites.
- On the calling sites, next after loading the base config file, act on
  errors in the same way as an err when loading each base config file
  (the effect in all cases is to use the default hardcoded values, when
  config is not present / not loadable)

Changes in v2:
- Use alternate functions to not change (raise) required Glib version
- Reformat code (styling)

---
Manuel A. Fernandez Montecelo (1):
  Support for config fragments (conf.d style dirs)

 Makefile.am                |   1 +
 profiles/input/hog.c       |   9 ++
 profiles/input/manager.c   |   9 ++
 profiles/network/manager.c |   9 ++
 src/conf_d.c               | 208 +++++++++++++++++++++++++++++++++++++
 src/conf_d.h               |  83 +++++++++++++++
 src/main.c                 |   9 ++
 7 files changed, 328 insertions(+)
 create mode 100644 src/conf_d.c
 create mode 100644 src/conf_d.h

-- 
2.51.0

