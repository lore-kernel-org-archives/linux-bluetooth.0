Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCFD1754B
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996802; cv=none; b=UzzQUPsriJ0vOetEHw1FVeiIUre+ve3rJzK6vbZ0saar3/HK+5NX381sbw0eVefPP7WxSDVnwL0zdt3xcDqwb9ECAzOdPujxZoi7fDkUg5wH7vP6zca3Qn14k1f0eW6hG6MLKwmlx7hPZO9kUB6MRFKU2vzW3N5zgpINZ12nxZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996802; c=relaxed/simple;
	bh=ZJrXIJGuj3G4MG4L3eI3U761Gf03rUDo6FIdGeoepHg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KPfIdPxHDnShEQeHONqy0LWr17x3NGYKM4dQa22CAVwYl9fafIb15zh6l2AddCCOBUvAJx42mMCRZvh3fYUjrGC8CmQc+cBIg6ZX30nQvJi1vM/4g//V2gv/ln7A5LgSB89FU6T+8I670UNK6AUCuko92XS16nZHxbEc4CvFtd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLZVNt4A; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLZVNt4A"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-87f0ac304f0so1296926241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 10:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751996798; x=1752601598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mIAIOjzIAUzbnFFG1Q8GtrEmsB0PRh/p/7NYNiu9zO4=;
        b=gLZVNt4AHyJegiEEUtmUeF83xUenTnF626nkm7A8P4EkUCgg0ZA+Nnpv/181h2ZLu+
         RvKVpeHgS8KeWbOCyQv4wD7gpoV9lJnhlt4Xa3kEWe5E0VGUp7X6jS27FFWJ2VXEn2IT
         LSreDSsN0JLhz8pny+lxMiOokstfJOvVRGBd9X8MhUd12KkJBHY5kN41eKIVm6I5+4TW
         9BuXtshvsKkih3kU4kGtPsnA5ZUI/2t0WIPHyMDxzhyZPhtppNSC+gxz6fO3OTZ4o+4m
         MLf9jwxfvKWY5NwYZuBEG1lNHbMQ0WZRAbvSZMvQpbPDM8ZqxO/6IT9M7sOWpwtSjuIS
         WmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751996798; x=1752601598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mIAIOjzIAUzbnFFG1Q8GtrEmsB0PRh/p/7NYNiu9zO4=;
        b=bOK5CoM2t0MqZ+9eD75/XihEu135rT0ekcWHQsfA6NH8VuCFGEfmdlXptKunmOeTGh
         n/eBNGdZBgEADw9H40cLNodlvvUJElkfhEQi3GuCg2hcOrpaP1ruzZQ2diqyxNp/3+LS
         i6d6tcw/XIGfKH6AwdMmSCtueJ06TpUdGBQn2P4ykPbwOS1h3a63PVFkLrkT1nX9FgOP
         TmAKfpqEncIxmHmfyprI6vnjPjTs1usB4kjLgC4y8pjza0YWJps8wVE7TGIi6UgoY37D
         WHzfvU8/cWAfKJ0VVuXJa7kc7aEAWdW92ZRMlPUCYa9JxbrzAlfItm/Vg03W+GkEAK1P
         IkbQ==
X-Gm-Message-State: AOJu0YwG0WZCQENF/qTb/DnQ/JfzevKa5F3e1tVaV19b4GYQKrcVJfEl
	n8B6HCVJfr00dzWxOkQH4ilu1LJbYE+bAdg7dyWVFm6kY8pFFB3S4SbVXQwKnA==
X-Gm-Gg: ASbGnctKzm3+IXA0y678UrIkQ+DUsQUKvzVxRhCdd426FnWQq5WynfBPZMDGdrgxQMp
	oNvILMt9GgBf823NVoZm0zSuy+UWw4EjTv1G1WmjAz3EFPTEL/Yf4wM6bDYcZgcYv3IwQ0OHjcN
	osjq2CXWc8rHx6KmS242Sw0977NAiHm9qlu74TwFfTHhLvWZ+y9eJECCvYG9A7plGe46lABxEnD
	VGjhah4Zyumw+iSbIYa6y+SD1fN99lO6nECcDDNGzOZ67qmLOowi1vvXeuO071b/t0b+H6/PrPL
	wU+53Bo8xBqc5ygEcqLQVbbtt/4noQExYCJi1mIFox5XpIFHmi4T5BAsLYopRNjqs4+6QWc6T7a
	C7M/D56yWJfeNbJpRE43QUi0K5OYm
X-Google-Smtp-Source: AGHT+IHGq+ffRr6XksR/AR/s/l+89lfB+QPCpym4kkZI6zmdRZbYCth6lsth1oaPwricKLotHXlQdA==
X-Received: by 2002:a05:6102:3e15:b0:4e2:c6e4:ab1e with SMTP id ada2fe7eead31-4f4b2b18e30mr594060137.7.1751996798298;
        Tue, 08 Jul 2025 10:46:38 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-886e93f19e7sm1938896241.29.2025.07.08.10.46.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:46:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/util: Introduce strnlenutf8
Date: Tue,  8 Jul 2025 13:46:28 -0400
Message-ID: <20250708174628.2949030-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces strnlenutf8 which works similarly to strnlen but return
only the number of valid bytes of UTF-8 encoded string then replace the
other copies of similar code.
---
 src/shared/util.c | 81 +++++++++++++++++------------------------------
 src/shared/util.h |  2 ++
 2 files changed, 31 insertions(+), 52 deletions(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index 4780f26b6d59..57f4d7bc00db 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1909,58 +1909,7 @@ char *strstrip(char *str)
 	return str;
 }
 
-bool strisutf8(const char *str, size_t len)
-{
-	size_t i = 0;
-
-	while (i < len) {
-		unsigned char c = str[i];
-		size_t size = 0;
-
-		/* Check the first byte to determine the number of bytes in the
-		 * UTF-8 character.
-		 */
-		if ((c & 0x80) == 0x00)
-			size = 1;
-		else if ((c & 0xE0) == 0xC0)
-			size = 2;
-		else if ((c & 0xF0) == 0xE0)
-			size = 3;
-		else if ((c & 0xF8) == 0xF0)
-			size = 4;
-		else
-			/* Invalid UTF-8 sequence */
-			return false;
-
-		/* Check the following bytes to ensure they have the correct
-		 * format.
-		 */
-		for (size_t j = 1; j < size; ++j) {
-			if (i + j > len || (str[i + j] & 0xC0) != 0x80)
-				/* Invalid UTF-8 sequence */
-				return false;
-		}
-
-		/* Move to the next character */
-		i += size;
-	}
-
-	return true;
-}
-
-bool argsisutf8(int argc, char *argv[])
-{
-	for (int i = 0; i < argc; i++) {
-		if (!strisutf8(argv[i], strlen(argv[i]))) {
-			printf("Invalid character in string: %s\n", argv[i]);
-			return false;
-		}
-	}
-
-	return true;
-}
-
-char *strtoutf8(char *str, size_t len)
+size_t strnlenutf8(const char *str, size_t len)
 {
 	size_t i = 0;
 
@@ -1997,6 +1946,34 @@ char *strtoutf8(char *str, size_t len)
 	}
 
 done:
+	return i;
+}
+
+bool strisutf8(const char *str, size_t len)
+{
+	return strnlenutf8(str, len) == len;
+}
+
+bool argsisutf8(int argc, char *argv[])
+{
+	for (int i = 0; i < argc; i++) {
+		if (!strisutf8(argv[i], strlen(argv[i]))) {
+			printf("Invalid character in string: %s\n", argv[i]);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+char *strtoutf8(char *str, size_t len)
+{
+	size_t i = 0;
+
+	i = strnlenutf8(str, len);
+	if (i == len)
+		return str;
+
 	/* Truncate to the longest valid UTF-8 string */
 	memset(str + i, 0, len - i);
 	return str;
diff --git a/src/shared/util.h b/src/shared/util.h
index 6fc02a9dcb5a..c480351d6e9f 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -90,6 +90,8 @@ do {						\
 char *strdelimit(char *str, char *del, char c);
 int strsuffix(const char *str, const char *suffix);
 char *strstrip(char *str);
+
+size_t strnlenutf8(const char *str, size_t len);
 bool strisutf8(const char *str, size_t length);
 bool argsisutf8(int argc, char *argv[]);
 char *strtoutf8(char *str, size_t len);
-- 
2.50.0

