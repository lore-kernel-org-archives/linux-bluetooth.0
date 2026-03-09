Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95691E9919
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 01:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773021491; cv=none; b=M1xgtKSTrXC10wA4NOtgHcjZwDipYJRRpHj3d3t/zOKPOWBHiK+Pa3SDjx9XlKW/tslknpBhWjf+l9VHc6q8o6jTXooeGY/S/REAiLbzUxYFy1+Fmep9ShFXC/bh2C3j7IDIl06DJkpeA0dZd4PI/VfbspD58dOwraMrsgxizJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773021491; c=relaxed/simple;
	bh=yNFJVzRpwO6TQe5TXWb22UnwIdnz/zs2/kWMv4Qltck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nxj6TDOfJR9CA7/hzJzE5mwiRUBuSFDHwtzREvJIt7eHQE6BKjoWg+xNjlNALfF46FDIzJZkdFjG+uv1rWUSxrT1IBUU2ydEjFAjpwzO/U03J3mqTpvj7vGxJBHUtLQw1K1JZyVYGRAM2Uh5W5vM2jzaolTaEUpnlATeoPCh7ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pp6dWjHl; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp6dWjHl"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506aa685d62so61334131cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Mar 2026 18:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773021489; x=1773626289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzNBi8a6WYUhidqF4/pppD09hJ6y83Rup3hwYwsa0qI=;
        b=Pp6dWjHlFZO9xEZQnVJR0ATx7zTF36eBiezk081Ka2kS2g6p2jWRcbTLwv6lrwvSOP
         zIbV5vZbOL4z2V2dIDR+zjq50SIibFanw4MSohtBsPSoqPiWnmlptRIvyyo6+TWXTKV+
         q17lkdWmknFh6agcaBNogq8vN7kV6nhEd5p/5TVlzHVyDawtEFAGT6w7p+2xq1hQEVgg
         Z81te20ve61GCLKUuzA5vyqawtN/zFRjKeRffsuB5bBkAhtk1UkEhmjzMJRrBkjIRMVr
         4OQ3ZtFGxuvIuEXkBlZ0zz3l8XnXHi4Nf5qoSvWR802sDB9WOLuBJkEm5qlBLiIrNbND
         cCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773021489; x=1773626289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DzNBi8a6WYUhidqF4/pppD09hJ6y83Rup3hwYwsa0qI=;
        b=Z7Fz7SbCboppPRyr82nwAjHK66KwBQhru8ArMxMEH3xQZk+gxlW5YzMScYl/qn9Srn
         DcON1M336Lz0RR1QiI3yDa+4OaH5M6FLmIfeHHAvrOg6e2fUAgSQcwAB/IGrZeYVEo+G
         hJhQ6Oa23LBog7UGnHGQAxlMU5Vy+1/qTZ4W9kLtENwHvrFpjiWOqqDdoxfR4Ah9+0e3
         vw5i/DqMDqUef5xN52JIfIcH5GSBMnjuScjl6pYr+WDMZFVF7t82v9lNDcI7s/g2+Ve1
         rDPBLk2tlS59VZitPz75DmYjrThwDhx1sTxgGfnI7G+xIKfs60VtqlE5/+PQ7A0sJbiP
         E2oQ==
X-Gm-Message-State: AOJu0Yy508ze2ge+g+Jx5vrTeDdyuM8/ADH+F2bmI+RfS6H6nOjS4wAQ
	w7+wC4cWK6Lv01p2clPXHq+kuEI+7ZOyaFmOC48i8v7wZre6HeID6yughn60PTDqBBU=
X-Gm-Gg: ATEYQzx8CsHETqutCRGBeO02eCvXcGAA/A8aHqBuAFh5Wvu9ntKHoW4SrJrNOT32hHd
	DFeANeZ9AtLDTC+kLt7kLGbW2riD8PJvFMnVSntnaVi4eNAiWvZksBtRluigIBnHzfdn41/Xmo1
	7PqJ0ZpyHw679sthI+tn3zSBERWpR91Zp0e5Jl/ra0UpRT6P3la4JMLMm3vUiJlVIVxpj4rQJ9l
	cMhrTDRbHFgqb0wlVUaJNZJbgaqOiyIjM4DJtg9nDQ1UZjos7vx07usFCn/F6X2rJdpsFLqy7ty
	4rtGcfZA7SojnlYh7yTUA7/ZbSHzUcwT/Bq2MeGamM0nuip1CVJ0W2w2l6slPDFwo69c9sW3zPA
	v2n7qH40mq6l9sBy2lY75cTfBl0xlsBTlz/EMD/N12YiVlso3Y8oZR2ek2ODOf1CDO/+T81mfob
	DAsUxN6hBHzFUe/5WKXyuBQpvBjhFBDQ59IhWR
X-Received: by 2002:ac8:5895:0:b0:509:1987:7628 with SMTP id d75a77b69052e-509198780f8mr26132591cf.53.1773021488636;
        Sun, 08 Mar 2026 18:58:08 -0700 (PDT)
Received: from gabes-pc ([184.145.175.55])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f6695738sm58616861cf.16.2026.03.08.18.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 18:58:08 -0700 (PDT)
From: Gabriel Woloz <wolozgabriel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gabriel Woloz <wolozgabriel@gmail.com>
Subject: [PATCH BlueZ 1/2] Added missing command "HCI Cmd Sync" to mgmt_op
Date: Sun,  8 Mar 2026 21:57:44 -0400
Message-ID: <20260309015745.1720-2-wolozgabriel@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260309015745.1720-1-wolozgabriel@gmail.com>
References: <20260309015745.1720-1-wolozgabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 lib/bluetooth/mgmt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bluetooth/mgmt.h b/lib/bluetooth/mgmt.h
index 1ad52529f..1c741ed55 100644
--- a/lib/bluetooth/mgmt.h
+++ b/lib/bluetooth/mgmt.h
@@ -1199,6 +1199,7 @@ static const char *mgmt_op[] = {
 	"Read Mesh Features",
 	"Mesh Send",
 	"Mesh Send Cancel",
+	"HCI Cmd Sync",
 };
 
 static const char *mgmt_ev[] = {
-- 
2.53.0.windows.1

