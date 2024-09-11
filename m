Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBC32C190
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066287; cv=none; b=tmpMrc6gHGBxfr0Oj3tsq7U2F6kqnx5ed4oimjO2QswpQm8AsChjIjpkqQNsFi+C/dOUCzLJRN34jRXpfr+niJkP3wQOc9UFORORbA99agz7g0OtuK52JH17PK0ruxfYLa3LcR+NyyKQCo/M4FxDeAT+eak4Fp1U1uPrc/LGoJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066287; c=relaxed/simple;
	bh=ju7Q7dpyogjscY8UQABILnJwLcUCWfo0qgPdOACJetw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYMzwOU0D5JfBMrXRiSkX1j3+M0eR3UwvtZpFmPtL6hpVIhKc79hLn8OUfK165bNISvLYVvAfHGrYgiYtUC4xiD7ZGOIg+e3VXIeb/YihIV0i7pTPk4EsgsA0DksHHBSrGtA7xfLEzYH+vH+B6jOQSf4hW+T9NEQh05E8OaWXtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgC5iJJa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgC5iJJa"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so26641335e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726066283; x=1726671083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DDt6An/rUCnxeJhf2QqhRrEmyR7X+IfsuPhjfNQIb/0=;
        b=CgC5iJJazQZeTbryMh+ANDpFKs0lumDWBrUaD42x1qa+n+/SsXwUoMhwxv1j/yfule
         5lxLQeVwkOyA/gTmocQ9Y9lpVUuP1E5pq4RMebOcjcovkAwDIz/bl5LXWVPDkov3MQCo
         f+MhqcLJ4J+vBtVlAiZJJqzewYn9iOl0GJJGzEsmW9jk3SZQGaoGjASb+r7zgqtQoAdn
         87a8ls9VurSBEFQQrgfsgZkqTdNCbeao7lQTdX45PyGYDJ+JjIkk5WgdNzEmqBkYOga5
         EyjjlT9Dnu4TQKttL5BrwHycT4xqp6KB91E3pETU3U99ihEkhUIU5Z4d0bWyGnGSEUTE
         qlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726066283; x=1726671083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDt6An/rUCnxeJhf2QqhRrEmyR7X+IfsuPhjfNQIb/0=;
        b=Ky3jfXSwgKNUzpkmsCjZDooYlwSj+Sv5hNwn75oTVr0Txur0EPGROVGy9zWbRtqCzl
         X3AuX7Z7W8v4YCZFm3wmHpGzbyJMNcPA/bTjBHwM+vIGIkrR0X8GSd3qK4aNXjBxUTcL
         IWL2Vs+x82CKTL4UD1yqUvoWlUmT5k7Kr/1eyp4U9CgTKcG7VBXQNuG4GH+DaRdglSOh
         VCSpO6WL1fNeOBgt1dlo2KhBg6ek2yfDPGNocrzNy+qx4G5spsSazGZ2N1ApJJunSiTh
         AJ3PNh1KuQ3M5ksw3IwGtanE8+ugsfSWLwMpY3wzpahKUF2HNYLeVSfDuWnFypRE/7cL
         /NRA==
X-Gm-Message-State: AOJu0YwL56RwDntSAtkVv3ddW4zFEp7zaxUtHnUlhSmoDFaZ5JuJfvJ6
	P8bKb0qga5DY5fipBzckLAjpFzRZMA+aLete2MrTjoqmRqB/tmQAljM5Nw==
X-Google-Smtp-Source: AGHT+IGy+VWDFHn7tWl1ehpVR08BEsfPg9g4z64G2YPrWjWRwBkT0D+ksVdP5Y7pe5x8GWhGTvVSQA==
X-Received: by 2002:a7b:ce88:0:b0:42c:b5a6:69bd with SMTP id 5b1f17b1804b1-42cb5a66a1bmr115878275e9.30.1726066282307;
        Wed, 11 Sep 2024 07:51:22 -0700 (PDT)
Received: from vibhavp-an515-58.lan ([2401:4900:1c63:4161:2261:f710:6aeb:b934])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665517sm12081277f8f.36.2024.09.11.07.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:51:21 -0700 (PDT)
From: Vibhav Pant <vibhavp@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vibhav Pant <vibhavp@gmail.com>
Subject: [PATCH BlueZ 0/2] adapter: Add (readwrite) Connectable property.
Date: Wed, 11 Sep 2024 20:21:12 +0530
Message-ID: <20240911145114.103340-1-vibhavp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds the "Connectable" property to Adapter objects in BlueZ. This
property is needed in order to implement the corresponding functionality for
Wine[1][2]. However, to not break current behaviour, enabling Discoverable while
Connectable is false will not result in an error.

[1]: https://learn.microsoft.com/en-us/windows/win32/api/bluetoothapis/nf-bluetoothapis-bluetoothenableincomingconnections
[2]: https://learn.microsoft.com/en-us/windows/win32/api/bluetoothapis/nf-bluetoothapis-bluetoothisconnectable

Vibhav Pant (2):
  adapter: Add support for the Connectable property.
  org.bluez.Adapter: Add documentation for the Connectable property.

 doc/org.bluez.Adapter.rst | 13 +++++++++++++
 src/adapter.c             | 25 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

-- 
2.46.0

