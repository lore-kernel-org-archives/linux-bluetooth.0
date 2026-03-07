Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6F296BDA
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Mar 2026 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772878923; cv=none; b=SNuTe/UehVQ6e7Pe9cWGlcAqeIlvJg2rHXNM+wkUPFTJ5Ha4/QxuNq7xGoOJSDTEiDUDr1KVTUEbcopDlXGEPTkXW9f8m7MKMjAQfeQxkN6VMCPCcGseitpB9UL93Lk22z8v1HFRG9S2yb9BmECrafWiIzLc9Qay2pNY4b7qmE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772878923; c=relaxed/simple;
	bh=yP0GswqMK+oagfUl3fUypz7Rymfv179LSWmsvxg4t6Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dMsWaYAv9H4HQCcYxK9HcuFsKeET6I2RzLUUdwLIJJprrsOQeUD6mooE+d4Q+9KKN8qPotMUCJxnyrGeeoqD+wLx1HBFv/qzTuhHffNXDMiHwJO06v0KYo9shtcAbM2mWK1NN9wP2FLiXdifkgWnm67qsMO5nw41ZLCK4iiVnq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-67ba64650d9so3813442eaf.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Mar 2026 02:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772878921; x=1773483721;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RpIQ5tLotXYAOL95K3vbmBUeuIMsSwPpzJAwNtBdHE=;
        b=a8y++To0vXDsrz/4lO6V3KiOxywp5cpnGLIqf2bvVstYfdBjoKGgcqgUXAJpq3n6HN
         shI3HLDvqnsZAjdfYxNoYcjDp6XGBbUX1vG5WVBJgyw1AGlyO1PIpAXUnmu4z/l/iugl
         qY5Bbb2d6nrCUlxhSwp+XhSHXOzoP8ZUweGlBaL8+85i2QXyZJW1LMyL/br6r+5oAHU4
         Md8xJyIPG7Cu+Lv04GRgxN/WA+e+/wxcUVdvgfuna5lrz5fu25+gKxcuMtRGAEhLX4D1
         pPNx8OC1j11Et8pv2pxWDwid7ys47lPrhWXSPYKDPRUpyLCRs9BZSmuCThvVfVUfyOn3
         6AMw==
X-Gm-Message-State: AOJu0YzW4PV637IHFcY10Uwp+OH9vNmnrYsO1j3Z0Qjp7X9pHc4u0olG
	wSOzl1vu++S6PXogQsr6DxT06uFqtRr4Rmh8hNviA2dBmYEXZrDswEIpFxy5HMQU5dJa1JvC0OD
	imFMRmdJpG39cApf2vonCdYAj3A/JF2/LR2BnB/8zve7QK/ICO9nhIQmopPo=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2210:b0:679:e750:6c06 with SMTP id
 006d021491bc7-67b9bd31cebmr3376028eaf.39.1772878921431; Sat, 07 Mar 2026
 02:22:01 -0800 (PST)
Date: Sat, 07 Mar 2026 02:22:01 -0800
In-Reply-To: <a36a0c60c12b6a8e09776875f2836f2e03894639.camel@iki.fi>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69abfc49.050a0220.13f275.0049.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_unregister_user
From: syzbot <syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, pav@iki.fi, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

can't ssh into the instance



failed to run ["ssh" "-p" "22" "-F" "/dev/null" "-o" "UserKnownHostsFile=3D=
/dev/null" "-o" "IdentitiesOnly=3Dyes" "-o" "BatchMode=3Dyes" "-o" "StrictH=
ostKeyChecking=3Dno" "-o" "ConnectTimeout=3D10" "root@10.128.1.197" "pwd"]:=
 exit status 255Pseudo-terminal will not be allocated because stdin is not =
a terminal.
Warning: Permanently added '[us-central1-ssh-serialport.googleapis.com]:960=
0' (ECDSA) to the list of known hosts.
UEFI firmware (version  built at 09:00:00 on Jan 10 2025)
EMU Variable FVB Started
EMU Variable invalid PCD sizes
Found PL031 RTC @ 0x9010000
InitializeRealTimeClock: using default timezone/daylight settings
=1B[2J=1B[01;01H=1B[=3D3h=1B[2J=1B[01;01H=1B[2J=1B[01;01H=1B[=3D3h=1B[2J=1B=
[01;01HBdsDxe: loading Boot0001 "UEFI Misc Device" from PciRoot(0x0)/Pci(0x=
2,0x0)/NVMe(0x1,00-00-00-00-00-00-00-00)
BdsDxe: starting Boot0001 "UEFI Misc Device" from PciRoot(0x0)/Pci(0x2,0x0)=
/NVMe(0x1,00-00-00-00-00-00-00-00)

UEFI: Attempting to start image.
Description: UEFI Misc Device
FilePath: PciRoot(0x0)/Pci(0x2,0x0)/NVMe(0x1,00-00-00-00-00-00-00-00)
OptionNumber: 1.

  Booting `syzkaller'


serialport: Connected to syzkaller.us-central1-a.ci-upstream-gce-arm64-test=
-job-parallel-1 port 1 (session ID: 496df2a91bf6754c27cb2596a739f60f4c94c5a=
4fc85884e1f75d06230ee71eb, active connections: 1).


syzkaller build log:
go env (err=3D<nil>)
AR=3D'ar'
CC=3D'gcc'
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_ENABLED=3D'1'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
CXX=3D'g++'
GCCGO=3D'gccgo'
GO111MODULE=3D'auto'
GOAMD64=3D'v1'
GOARCH=3D'amd64'
GOAUTH=3D'netrc'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOCACHEPROG=3D''
GODEBUG=3D''
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFIPS140=3D'off'
GOFLAGS=3D''
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build262281762=3D/tmp/go-build -gno-record-gcc=
-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.26.0'
GOWORK=3D''
PKG_CONFIG=3D'pkg-config'

git status (err=3D<nil>)
HEAD detached at c06e8995d7
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Darm64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dc06e8995d711b5a8d8fbd771826fcbfdac6f110f -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20250811-165554"  -o ./bi=
n/linux_arm64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_arm64
aarch64-linux-gnu-g++ -o ./bin/linux_arm64/syz-executor executor/executor.c=
c \
	-O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-l=
arger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-ove=
rflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -stati=
c-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH_arm6=
4=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"c06e8995d711b5a8d8fbd771826fcbfdac=
6f110f\"
/usr/lib/gcc-cross/aarch64-linux-gnu/14/../../../../aarch64-linux-gnu/bin/l=
d: /tmp/ccHQpBys.o: in function `Connection::Connect(char const*, char cons=
t*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x2ec): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking



Tested on:

commit:         1e0a8362 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.g=
it for-kernelci
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1aef92cd87e68b9=
f
dashboard link: https://syzkaller.appspot.com/bug?extid=3D14b6d57fb728e27ce=
23c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-=
1~exp1~20251221153213.50), Debian LLD 21.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D10e4075a5800=
00

