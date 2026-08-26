Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC764252A8
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750786; cv=none; b=RzbcG/Jm7Meg0ZR4WBCj3BWaBmrzKLJ+5wCkRZJKTFulzcxx5IElHqbq4IdM0H3dGO6zFnpTbGVpjrK+8Zxyf+KVxp40kVTHI1s9zXUWrMqB760DpUdc3S+zpSab0fjc3NoKM7+TqaQG5cLBZIAopT0OkF3iQyQ99UC7yl44LvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750786; c=relaxed/simple;
	bh=p2EQJlpOCxrfKKkGSq0cyU71UcvE7hKEPjSC279Kb28=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiVIOrWjDR+MOJMWaekHv+tfmRc/VEukI0YOq4V4IQtVzKvSFRRUhyH8ARyjaZLcg/LzxWFxJYO598z2XueZu0hkB8qzluYGZiGTKGoZ+mtnPIz3C93t/GjMQmbxY2qeiBhxF5Z548D05NA8J0IqdJ0IMZkY/JnhL9tFve4bNhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4CDC23EDCC
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 13:26:21 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v2 2/2] doc: Remove obsolete security-bugs.rst
Date: Wed, 26 Aug 2026 15:19:06 +0200
Message-ID: <20260826132610.1021538-3-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826132610.1021538-1-hadess@hadess.net>
References: <20260826132610.1021538-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTGQaFcjOVtuj7jE2/x2FIOISvuGpgSS3du39tkBRUnKYm26+HrOXh/ELwRCws7zxwtVOQ3n63lpoPKv4fznNTIS8ukhcfbbEOK3BRSiPCblL3rDEqzElggW8dNslsK7PvzFpd63B8UV4jF92Dc/CFJKgPuCN2tldL9lQFWZdEmuDUPeGbejwKPKOGR2ENivN/XsuTc/W//zOoLS3MWcSdhHG+k9h1vFckVFcdhk35+NWrbzOulm6vPePeNSqoI9vkYB5wWAPqAohVyUKulQEz//dbuLLi5G1GMC4vEjCyc98tKpO5uaFjnGycYT24QfV/21zb8V52Oeki2/t6ivwcOZUIPKp+DBiFpgZ43olRp317lMAsJMnhUqttKfb8VR/csTxeZYDJheXBkzcS7t9bJxfpneCp/qQyUtK2X7bNxPBLzMMs559ZgJ+baLrQ+safTpYER22M8MkEpqoEFETuSYXjMw7sLYqx9ft4hqm/Q97sGNkwFXnGFEXeLHYA87RDhWSinG7hf8JXyKb6rGEJvN9alohlPvPnntcPaVUae8M7Rcz9jvWUbomrareNb3ATFV7/aTuUFSTLaPf7p5tkpaJ3byxao/Gqs098B5lbkVxDyQLEYL/BnORc0auF6viu9TPNQ6TedLZOy2EjRUSjamnrb7o9B7s7YyNYe0uHodnw
X-GND-State: clean
X-GND-Score: 0

---
 doc/security-bugs.rst | 89 -------------------------------------------
 1 file changed, 89 deletions(-)
 delete mode 100644 doc/security-bugs.rst

diff --git a/doc/security-bugs.rst b/doc/security-bugs.rst
deleted file mode 100644
index 0dcacfbd9eac..000000000000
--- a/doc/security-bugs.rst
+++ /dev/null
@@ -1,89 +0,0 @@
-=============
-Security bugs
-=============
-
-BlueZ developers take security very seriously.  As such, we'd like to know
-when a security bug is found so that it can be fixed and disclosed as quickly
-as possible.  Please report security bugs to the BlueZ security team.
-
-
-Contact
--------
-
-The BlueZ security team can be contacted by email at <security@bluez.org>.
-This is a private list of security officers who will help verify the bug
-report and develop and release a fix.  If you already have a fix, please
-include it with your report, as that can speed up the process considerably.
-
-As it is with any bug, the more information provided the easier it will
-be to diagnose and fix.  Any exploit code is very helpful and will not
-be released without consent from the reporter unless it has already been
-made public.
-
-Please send plain text emails without attachments where possible.
-
-
-Disclosure and embargoed information
-------------------------------------
-
-The security list is not a disclosure channel.  For that, see Coordination
-below.
-
-Once a robust fix has been developed, the release process starts.  Fixes
-for publicly known bugs are released immediately.
-
-Although our preference is to release fixes for publicly undisclosed bugs
-as soon as they become available, this may be postponed at the request of
-the reporter or an affected party for up to 7 calendar days from the start
-of the release process, with an exceptional extension to 14 calendar days
-if it is agreed that the criticality of the bug requires more time.  The
-only valid reason for deferring the publication of a fix is to accommodate
-the logistics of QA and large scale rollouts which require release
-coordination.
-
-While embargoed information may be shared with trusted individuals in
-order to develop a fix, such information will not be published alongside
-the fix or on any other disclosure channel without the permission of the
-reporter.  This includes but is not limited to the original bug report
-and followup discussions (if any), exploits, CVE information or the
-identity of the reporter.
-
-In other words our only interest is in getting bugs fixed.  All other
-information submitted to the security list and any followup discussions
-of the report are treated confidentially even after the embargo has been
-lifted, in perpetuity.
-
-
-Coordination
-------------
-
-Fixes for sensitive bugs, such as those that might lead to privilege
-escalations, may need to be coordinated with the private
-<linux-distros@vs.openwall.org> mailing list so that distribution vendors
-are well prepared to issue a fixed package upon public disclosure of the
-upstream fix.  Distros will need some time to test the proposed patch and
-will generally request at least a few days of embargo, and vendor update
-publication prefers to happen Tuesday through Thursday. When appropriate,
-the security team can assist with this coordination, or the reporter can
-include linux-distros from the start.  In this case, remember to prefix
-the email Subject line with "[vs]" as described in the linux-distros wiki:
-<http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
-
-
-CVE assignment
---------------
-
-The security team does not normally assign CVEs, nor do we require them
-for reports or fixes, as this can needlessly complicate the process and
-may delay the bug handling. If a reporter wishes to have a CVE identifier
-assigned ahead of public disclosure, they will need to contact the private
-linux-distros list, described above. When such a CVE identifier is known
-before a patch is provided, it is desirable to mention it in the commit
-message if the reporter agrees.
-
-
-Non-disclosure agreements
--------------------------
-
-The BlueZ security team is not a formal body and therefore unable to enter
-any non-disclosure agreements.
-- 
2.55.0

