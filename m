Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905F230DEBA
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648253; cv=none; b=stH2rJFN/G30A0f01O+Y1pGtczud9jqxhzDOPunZp2OhpcVVtHoeKuQMwaow6826GYGAd857GlwhePwIiqTKDbAPfN6rYe1DdIyH1unIg3mAuwSmHgYrBkPoOylg0PJHyF5JGQRImW/1oWG2sz1Vul0+s8K4JEUjkHMzmwvZd+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648253; c=relaxed/simple;
	bh=zr6FxhQVls3yQ3YNyV1vhpwx880dNIEwZf8ACghiPPI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gh+0n0vwJ1eeFAe2CZmIDx5JfYMXTVmd0Ye2j9HnVHY60LdH/7DmxoFl4r391YU/E2o7VyTjV6X+FJWacklXpYNG1hbGX0AEqvmPrLMJEL6m2bBavxgzYrznTb28EJJkjBmDKP5bLSRX6Fbc8F4/Gw8mLA25eUCW+MTwjjEWs1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 340F13EBED
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 08:57:23 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] SECURITY: Add top-level security doc
Date: Tue, 25 Aug 2026 10:55:54 +0200
Message-ID: <20260825085714.448937-2-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825085714.448937-1-hadess@hadess.net>
References: <20260825085714.448937-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTGAabt3qcdE/Z+cp08o0tTlZvIJgos3QSIpJaVWLV03++iVL3tb2StBB0tv2uOaua0rQbXVmFovBXiUkgzKOaUuEbbmbE5X00Lglun4Xm3wSwVpvqZ1jfMKIDP+zq5uOQFnbmV5iISSswUJwM5oh0sLOKS4Pk/fpKCw3loT5/78Er+t0v/4W31GQ7yuW9P/YUOquDGg717lhgL3gUr1BSdKq10uDNvIalYqKZChQ/MVI15UbVVt2Sc9fSvNp5RJ9H8d9ocaQMn3RVpBB9rsnmeYGkTyj8rcMYDvuOJGQOYdRHq1UoWQOCJe+Nd7GGSHFMKQ29fJWowBWRBpBq5MqNjQYmbFq8h4wOOkCUTfwqDf++Mlnu/KUK2iE6Jd/jRrvqeUxMYqY3ExkcnehVxe6dKmM3xMYTu1maytJW+U4rpKJlsaqVhuK0PMhGDtU91SUUSJuicM2rH6NPaSLhqfW7J+q4CRFc+9WwfnbcjdGYeSwmsRpeeLQbVg2R1plcuZTbvXr18TTWUrELVoaCvBdoSa5FxmGf6B+m80l+y82wrM8ldBpjKKcotHc22jdLjzBW4w/HczlUMF1ZL8JzWiCyIA7/lptQGgavPP8XpS2HmccqsBDGFaQDZiybkk0j+uCqrqP5uDDvc9AKTJ0heuPj7JMoZHlWV6qFm8W7Nq6gjgxg
X-GND-State: clean
X-GND-Score: 0

This will replace the existing documentation written 5 years ago to take
into account the new tools and the new rules around dealing with
security issues.

The new workflow replaces email-based reporting with the GitHub security
advisory tools, explains the CVE ID assignment process, and places strict
limits on the amount of work that can be demanded from BlueZ developers.

It is customary in 2026 to have a top-level SECURITY.md file which
explains the vulnerability workflow.
---
 SECURITY.md | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 SECURITY.md

diff --git a/SECURITY.md b/SECURITY.md
new file mode 100644
index 000000000000..b4b903de6a10
--- /dev/null
+++ b/SECURITY.md
@@ -0,0 +1,88 @@
+# Security Policy
+
+## How to Report a Potential Vulnerability?
+
+If you are reporting a not-yet released or urgent issue, please file a draft
+security advisory at
+[https://github.com/bluez/bluez/security/advisories](https://github.com/bluez/bluez/security/advisories),
+containing as many details as possible, including the version affected, and
+any ways to reproduce or fix the problem.
+
+## AI usage
+
+If the vulnerability was found using AI assistance the reporter needs to
+disclose that within the report, also needs to mention which AI was used
+during the processes.
+
+## Embargoed vulnerabilities
+
+All security advisories filed through GitHub will be embargoed until
+either a fix is available in the [main BlueZ repository](https://git.kernel.org/pub/scm/bluetooth/bluez.git/)
+([mirror](https://github.com/bluez/bluez/)), or it has been made public
+by a third-party.
+
+GitHub security advisories have discussion fields, and those discussion fields
+will stay private even after the advisory has been made public. Only trusted
+BlueZ developers will have access to those comments, and unpublished advisories.
+In exceptional circumstances, outside security developers might get access
+to advisories if BlueZ developers find it to be necessary for assessment,
+coordination or publication.
+
+## CVE number assignment
+
+All the vulnerabilities reported through GitHub's security advisories feature
+will be assigned a unique GHSA, which can be used to reference the issue
+externally.
+
+BlueZ maintainers will aim to work with either
+[GitHub](https://docs.github.com/en/code-security/concepts/vulnerability-reporting-and-management/repository-security-advisories#cve-identification-numbers)
+or [Red Hat](https://access.redhat.com/articles/red_hat_cve_program) as CNAs
+to get CVE IDs assigned, on a best effort basis.
+
+Vulnerabilities reported publicly through the linux-bluetooth mailing-list,
+or in any other manner, will not be assigned CVE IDs, and BlueZ maintainers
+will not be working with CNA to get a CVE ID assigned to that vulnerability.
+
+## Disclosure
+
+Once an issue has been discussed privately, accepted as a security issue by
+BlueZ developers, a fix created, and if the severity of the issue is
+high enough (usually only for critical/high), BlueZ developers will aim
+to have distributions forewarned about the issue through the private
+[linux-distros@vs.openwall.org](mailto:linux-distros@vs.openwall.org) mailing-list.
+
+Note that we recommend informing BlueZ developers and working on a fix first,
+before involving the `linux-distros`, as this list has a relatively short
+embargo period which might not allow for much time for the BlueZ developers
+to create and test robust fixes.
+
+We will not be applying any further embargo, or do any restricted disclosure
+for issues that are considered of low or moderate severity.
+
+## Severity assessment
+
+Some Bluetooth functionality is gated behind the `--enable-experimental`
+build option, and behind the `-E/--experimental` command-line option.
+
+When security issues exist in such gated functionality, the security
+level for the issue will be considered as `Low`. This will be done by
+setting the following CVSS fields:
+
+- *Privileges Required*: `High` (requires having an experimental build, and the daemon running as experimental)
+- *Confidentiality*, *Integrity* and *Availability*: `Low`
+
+Reports should take into account the systemd sandboxing features enabled
+in the configuration shipped by BlueZ upstream, if they are applicable
+to the vulnerable portion of the codebase. Issues that only manifest
+themselves when running unsandboxed will have their severity lowered
+as appropriate.
+
+Similarly, Denial-of-Service issues will only be considered as security
+issues if they can be triggered without human intervention, or set up
+on the BlueZ side, otherwise please report those problems as bugs
+using the normal process.
+
+## Non-disclosure agreements
+
+The BlueZ developers are not a formal body and therefore unable to enter
+any non-disclosure agreements.
-- 
2.55.0

