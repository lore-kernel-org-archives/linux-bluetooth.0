Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C326F293
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 02:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768445704; cv=none; b=A9rtyW90KqyqcsEMRzUbjDs7pV/JuM9mfKPrySP8ZjRYv9MB+/wwc0Wt/QR/tSvHKiuV1oZf84gRDGVokOk4qzPJYPd6v036X71PmVgOG5LCF013mbG0bkZmw4hPlOsFK+jYOHCbjAsQNol7gO3wPHqYbRay5dJ5N+SrAqoGrq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768445704; c=relaxed/simple;
	bh=7n03I34tNSbzydFb/9vfSqq25WdcRUxlV4nEpweZkwU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PCr8SQnvVVs3eszgi4i/CHrVdzU8H63sy7PUIxOJx7dBWECk1Po3sOZC9/Dv1jV16q052bYxZhq8/8OwaEYNA1ShtaMGtE+2P6O/gIGrfvvIOXew2aVqy1tcWp6ravAgkfaJ1UUErA5U96HHlUwMzTpi1Xlh4MBj2dmyWsbuysI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Mm3rduxc; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Mm3rduxc"
Received: from github.com (hubbernetes-node-898ea9d.ash1-iad.github.net [10.56.208.51])
	by smtp.github.com (Postfix) with ESMTPA id CF0CC6003B6
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 18:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768445702;
	bh=erTAVLteoaB6al+ywLbP1Gg7b92+b2RYhLKfVrcrkao=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Mm3rduxcB5I3PFosCzi1jvULLU4ywAVasFB8xUOoRjLRXtvpgD+mxaDnsQ+0Vq7Lu
	 x+26ZmoOc1rut9qdtxzDmn6QXPCY/649UJ50JIFBT7fIH4VSwj1V1ec6GUdTUqmmor
	 rvDKUaznROBQfHvCOn0ByFAD4BYPTV3qSjqF53zg=
Date: Wed, 14 Jan 2026 18:55:02 -0800
From: "Manuel A. Fernandez Montecelo" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1042572/000000-5567c2@github.com>
Subject: [bluez/bluez] 5567c2: Support for config fragments (conf.d style
 dirs)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1042572
  Home:   https://github.com/bluez/bluez
  Commit: 5567c2249c4a13d054eb3f117f1c51584dbb7df0
      https://github.com/bluez/bluez/commit/5567c2249c4a13d054eb3f117f1c51584dbb7df0
  Author: Manuel A. Fernandez Montecelo <mafm@igalia.com>
  Date:   2026-01-15 (Thu, 15 Jan 2026)

  Changed paths:
    M Makefile.am
    M profiles/input/hog.c
    M profiles/input/manager.c
    M profiles/network/manager.c
    A src/conf_d.c
    A src/conf_d.h
    M src/main.c

  Log Message:
  -----------
  Support for config fragments (conf.d style dirs)

Support config fragments, to read config from conf.d directories.
Those dirs will be main.conf.d for main.conf, analog for input.conf
and network.conf.

This is commonly supported by other tools, as an extension of the main
config file(s).  It is useful and convenient in several situations,
for example:

* distributions can set different values from the defaults shipped
  upstream, without having to modify the config file

* different packages or config-management tools can change config just
  by adding, removing or modifying files in that directory; instead of
  editing the main config files

The main or base config files will be processed first, and then files
in the corresponding conf.d dirs, if existing.

When reading these config files in conf.d dirs, they override values
for keys in the base config files (or default config set in code).
For example, for "main.conf" the directory to be processed will be
"main.conf.d", in the same basedir as the config file
(e.g. /etc/bluetooth/main.conf, /etc/bluetooth/main.conf.d/).  The
same for input.conf and network.conf.

Within the conf.d directory, the format of the filename should be
'^([0-9][0-9])-([a-zA-Z0-9-_])*\.conf$', that is, starting with "00-"
to "99-", ending in ".conf", and with a mix of alphanumeric characters
with dashes and underscores in between.  For example:
'01-override-general-secureconnections.conf'.

Files with a different name scheme will not be considered.  Accepting
groups or keys not present in the base config depends on the code,
currently set to "NOT accept new groups" but "YES to accept new keys".
This is because the base config files as shipped contain all the
groups, but most keys are commented-out, with the default values set
in code.

The candidate files within the given directory are sorted (with
g_strcmp0(), so the ordering will be as with strcmp()).  The
configuration in the files being processed later will override
previous config, in particular the main/base config files, but also
the one from previous files processed, if the Group and Key coincide.

For example, consider 'main.conf' that contains the defaults:

  [General]
  DiscoverableTimeout=0
  PairableTimeout=0

and there is a file 'main.conf.d/70-default-timeouts-vendor.conf'
containing settings for these keys:

  [General]
  DiscoverableTimeout=30
  PairableTimeout=30

and another 'main.conf.d/99-default-timeouts-local.conf'
containing settings only for 'PairableTimeout':

  [General]
  PairableTimeout=15

What happens is:
1) First, the 'main.conf' is processed as usual;
2) then 'main.conf.d/70-default-timeouts-vendor.conf' is processed,
   overriding the two values from the main config file with the given
   values;
3) and finally 'main.conf.d/99-default-timeouts-local.conf' is
   processed, overriding once again only 'PairableTimeout'.

The final, effective values are:

  DiscoverableTimeout=30
  PairableTimeout=15



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
