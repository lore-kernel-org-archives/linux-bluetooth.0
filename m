Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D422701CB
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 21:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765487856; cv=none; b=mPYhWEVTnUkvpXEw9K27kEVtbBmPQ0hb9Rw0dI2ba7CbNPuw4W33oyPCESHOWAG1jjPN1801znvZt5dwzbeLbxIqDaRsORBAISL/JV5Hbx2zeC7i1Lsld+bsKbTmZY1y5T3mkEgXrtSyvlDOOJOeKboIFr9fzyEmUr26lTlRi7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765487856; c=relaxed/simple;
	bh=3ZKCLdQ5V7vfr02FS+baYgm6WctDn6xapRECbyG4LTY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jjPdcy4S3tq8WZT59NL9Pxryr5LvlX5d6pYDu6ZdzzqXPJS9xax6xCFxsY9v3pq/Ht3Wd5FYWP9rWSfi1RPAZRz/wh8QN8faNKU+VrlwZ6LQzZ+lIlhRbyY5CFaXIsX9+w+C+4b7NJkeGH7G8RZZ5T5Kurrj20X1R23AOXGvoEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QGo6dBsI; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QGo6dBsI"
Received: from github.com (hubbernetes-node-a757b4c.ac4-iad.github.net [10.52.220.43])
	by smtp.github.com (Postfix) with ESMTPA id D160C204EB
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 13:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765487853;
	bh=wYl5RNg0IXSuwrDP1o7bxvgHmxrrdPE+y8TVMoyEzq4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QGo6dBsIT4rYoWr39KejV9XZR281ivGb8ezIK78hHBAqcfJ4cd7BBT67iuoWQd5Pp
	 HeOCMSdx0rdmh8yLJWzRWFjdITVWSHPrcLcOjzuqyxvXqBwOYsBNcbPO2fg69B9jSC
	 ep4cavtdazKSgkvI2WNQEpxuRKG/RFAnQhfj6nA4=
Date: Thu, 11 Dec 2025 13:17:33 -0800
From: "Manuel A. Fernandez Montecelo" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032437/000000-3ff490@github.com>
Subject: [bluez/bluez] 3ff490: Support for config fragments (conf.d style
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

  Branch: refs/heads/1032437
  Home:   https://github.com/bluez/bluez
  Commit: 3ff4906bcf774600491427be70e5249b066a4eae
      https://github.com/bluez/bluez/commit/3ff4906bcf774600491427be70e5249b066a4eae
  Author: Manuel A. Fernandez Montecelo <mafm@igalia.com>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    M Makefile.am
    M acinclude.m4
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

- distributions can set different values from the defaults shipped
  upstream, without having to modify the config file

- different packages or config-management tools can change config just
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
