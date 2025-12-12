Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F99C30BBA3
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765572048; cv=none; b=hEtz0HvykrJU8KTT8OnMI0FXIHBtQNHY8BteGSZqyPo9uxf+R6ObfPtj67tE9v6j0Wjrm1AIfSyH0I3HwsH0kJzlyENyeNgPf8aqz5N+W+1vEl7LkmsCjrizhK0/Jrjxu/2V+x+4Q8QVcuCHTu5pJvYx/3bxoyzi+myfe9B0iH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765572048; c=relaxed/simple;
	bh=2dnzX5J6STz4o+aishZwbovmr0Kjm+xxcn8O7npm6jQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NfT3ytTvDQT1oVjl0CuqA4elF4fNe+7Ggl18sYps4SUzUBxCYM4sl6RBWLcaAnIzauo6p9zyR4i1T1OF/sEQ+sIaZMVW37BwBlBxjNeI1IwCQs+j9eNjo6tooXdd4RsL9kxTu3RbKfGfk0UreluHUpYY974lSAO40Y/1QU9EXgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Aoj9KTqr; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Aoj9KTqr"
Received: from github.com (hubbernetes-node-576f47a.ash1-iad.github.net [10.56.202.38])
	by smtp.github.com (Postfix) with ESMTPA id 669641411FC
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 12:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765572046;
	bh=THi3GZVKkFtudQ//d7GwNZsrrsFxva1WRHQZkqRCEYs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Aoj9KTqrFKP41CY6np0AbFVNpQSatJ/NwhxCIa7euMv4cgh76oQuMa0y+2GNV+R+P
	 SHmS4eXwXB56OlFecxioffQzmRseURk2go3G2qTjmFwM8zgxjjGZOn7cey/i8Ql4/w
	 VibE4qX7FKuwBKJ6Xlf8GdqZ3tPCs5Fo9gpRvceI=
Date: Fri, 12 Dec 2025 12:40:46 -0800
From: "Manuel A. Fernandez Montecelo" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032731/000000-e1205d@github.com>
Subject: [bluez/bluez] e1205d: Support for config fragments (conf.d style
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

  Branch: refs/heads/1032731
  Home:   https://github.com/bluez/bluez
  Commit: e1205d287332ce18f1ba5cf3795b59d7db627f5a
      https://github.com/bluez/bluez/commit/e1205d287332ce18f1ba5cf3795b59d7db627f5a
  Author: Manuel A. Fernandez Montecelo <mafm@igalia.com>
  Date:   2025-12-12 (Fri, 12 Dec 2025)

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
in the conf.d dirs, if existing.

When reading these config files in conf.d dirs, they override values
for keys in the base config files (or default config set in code).
For example, for "main.conf" the directory to be processed will be
"main.conf.d", in the same basedir as the config file
(e.g. /etc/main.conf, /etc/main.conf.d/).  The same for input.conf and
network.conf.

Within the conf.d directory, the format of the filename should be
'^([0-9][0-9])-([a-zA-Z0-9-_])*\.conf$', that is, starting with "00-"
to "99-", ending in ".conf", and with a mix of alphanumeric characters
with dashes and underscores in between.  For example:
'01-override-general-secureconnections.conf'.

Files named differently will not be considered, and accepting groups
or keys not present in the base config depends on the code, currently
set to "NOT accept new groups" but "YES to accept new keys".  This is
because the base config files contain all the groups, but most keys
are commented-out, with the values set in code.

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
